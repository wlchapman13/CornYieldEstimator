//
//  ViewController.swift
//  CornYieldEstimator
//
//  Created by WILLIAM CHAPMAN on 7/24/17.
//  Copyright © 2017 WILLIAM CHAPMAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var yieldModel = YieldModel()
    
    @IBOutlet weak var fieldRowWidthLabel: UILabel!
    
    @IBOutlet weak var sampleLengthLabel: UILabel!
    
    @IBOutlet weak var numberOfPlantsInSampleLabel: UILabel!
    
    @IBOutlet weak var numberOfEarsInSampleLabel: UILabel!
    
    @IBOutlet weak var kernalsAroundEar3: UILabel!
    @IBOutlet weak var kernalsInRowEar3: UILabel!
    
    @IBOutlet weak var kernalsAroundEar7: UILabel!
    @IBOutlet weak var kernalsInRowEar7: UILabel!
    
    @IBOutlet weak var kernalsAroundEar10: UILabel!
    @IBOutlet weak var kernalsInRowEar10: UILabel!
    
    @IBOutlet weak var aveKernalsInRowLabel: UILabel!
    @IBOutlet weak var aveKernalsInColumnLabel: UILabel!
    
    @IBOutlet weak var yieldPerAcreLabel: UILabel!
    @IBOutlet weak var actualPlantPopulationPerAcre: UILabel!
    @IBOutlet weak var actualEarPopulationPerAcre: UILabel!
    
    @IBOutlet weak var kernalSlider: UISlider!
    @IBOutlet weak var kernalsPerBushelLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var yieldRecords: [YieldRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "previousYieldCell")
        
        updateUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        updateUI()
        getData()
        tableView.reloadData()
    }
    
    func getData() {
        do {
            yieldRecords = try context.fetch(YieldRecord.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    fileprivate func updateUI() {
        print("inside updateUI...")
        fieldRowWidthLabel.text = "\(yieldModel.rowsPerField) inches"
        
        let sampleFeet = Int(yieldModel.sampleLengthInches / 12)
        let sampleInches = Int(round(yieldModel.sampleLengthInches-Double(sampleFeet*12)))
        
        
        sampleLengthLabel.text = "Measure \(sampleFeet) feet \(sampleInches) inches on a tape measure as a sample"
        
        numberOfPlantsInSampleLabel.text = "\(Int(yieldModel.numberOfPlantsInSample)) plants"
        numberOfEarsInSampleLabel.text = "\(Int(yieldModel.numberOfEarsInSample)) ears"
        
        kernalsAroundEar3.text = "\(Int(yieldModel.kernalsInColumn[0])) kernals"
        kernalsInRowEar3.text = "\(Int(yieldModel.kernalsInRow[0])) kernals"
        
        kernalsAroundEar7.text = "\(Int(yieldModel.kernalsInColumn[1])) kernals"
        kernalsInRowEar7.text = "\(Int(yieldModel.kernalsInRow[1])) kernals"
        
        kernalsAroundEar10.text = "\(Int(yieldModel.kernalsInColumn[2])) kernals"
        kernalsInRowEar10.text = "\(Int(yieldModel.kernalsInRow[2])) kernals"
        
        aveKernalsInColumnLabel.text = "Average kernals across: \(yieldModel.aveKernalsInColumn.roundTo(places: 2))"
        aveKernalsInRowLabel.text = "Average kernals along row: \(yieldModel.aveKernalsInRows.roundTo(places: 2))"
        
        yieldPerAcreLabel.text = "Yield in bushels per acre is \(yieldModel.yieldPerAcre.roundTo(places: 1))"
        actualPlantPopulationPerAcre.text = "Actual plant population per acre : \(yieldModel.numberOfPlantsInSample*1000.0)"
       actualEarPopulationPerAcre.text = "Actual ear population per acre : \(yieldModel.numberOfEarsInSample*1000.0)"
        
        kernalsPerBushelLabel.text = "\(Int(yieldModel.kernalsInBushel))"
    }
    
    @IBAction func kernalSliderUpdated(_ sender: Any) {
        
        let fixed = roundf((sender as! UISlider).value / 1000.0) * 1000.0;
        (sender as AnyObject).setValue(fixed, animated: true)
        
        yieldModel.kernalsInBushel = Double(kernalSlider.value)
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFieldRowWidth"
        {
            let controller = segue.destination as! ChooseRowWidthViewController
            controller.yieldModel = self.yieldModel
        }
        if segue.identifier == "segueToNumberOfPlantsAndYears"
        {
            let controller = segue.destination as! ChooseNumberOfPlantsAndEarsViewController
            controller.yieldModel = self.yieldModel
        }
        if segue.identifier == "segueToNumberOfKernalsEar3"
        {
            let controller = segue.destination as! ChooseNumberOfKernalsViewController
            controller.yieldModel = self.yieldModel
            controller.earNumber = 0
        }
        if segue.identifier == "segueToNumberOfKernalsEar7"
        {
            let controller = segue.destination as! ChooseNumberOfKernalsViewController
            controller.yieldModel = self.yieldModel
            controller.earNumber = 1
        }
        if segue.identifier == "segueToNumberOfKernalsEar10"
        {
            let controller = segue.destination as! ChooseNumberOfKernalsViewController
            controller.yieldModel = self.yieldModel
            controller.earNumber = 2
        }
        if segue.identifier == "saveYieldDataSegue"
        {
            let controller = segue.destination as! SaveYieldViewController
            controller.yieldModel = self.yieldModel
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return yieldRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? =
            tableView.dequeueReusableCell(withIdentifier: "previousYieldCell")
        if (cell != nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: "previousYieldCell")
                // let cell = UITableViewCell()
                let aRecord = yieldRecords[indexPath.row]
        
                if let aFieldName = aRecord.fieldName {
                    cell?.textLabel?.text = aFieldName+" estimated yield : \(aRecord.yield)"
                }
                if let aDate = aRecord.timestamp {
                    
                    let calendar = Calendar.current
                    var hour = calendar.component(.hour, from: aDate)
                    let minutes = calendar.component(.minute, from: aDate)
                    let month = calendar.component(.month, from: aDate)
                    let day = calendar.component(.day, from: aDate)
                    let year = calendar.component(.year, from: aDate)
                    var ampmIndicator = "am"
                    
                    if hour > 12 {
                        ampmIndicator = "pm"
                        hour = hour - 12
                    }
                    
                    cell?.detailTextLabel?.text = "\(hour):\(minutes)\(ampmIndicator) \(month)/\(day)/\(year)"
                }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = yieldRecords[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                yieldRecords = try context.fetch(YieldRecord.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


