//
//  SaveYieldViewController.swift
//  CornYieldEstimator
//
//  Created by WILLIAM CHAPMAN on 7/31/17.
//  Copyright © 2017 WILLIAM CHAPMAN. All rights reserved.
//

import UIKit

class SaveYieldViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    var date = Date()
    
    //  reference to the Yield Model
    var yieldModel = YieldModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        var ampmIndicator = "am"
        
        if hour > 12 {
            ampmIndicator = "pm"
            hour = hour - 12
        }
        
        self.yieldLabel.text = "\(yieldModel.yieldPerAcre.roundTo(places: 1))"
        self.dateLabel.text = "\(hour):\(minutes)\(ampmIndicator) \(month)/\(day)/\(year)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveWasPressed(_ sender: Any) {
        print("save button was pressed ... start core data magic")
        let thisContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let yieldRecord = YieldRecord(context: thisContext)
        
        yieldRecord.yield = yieldModel.yieldPerAcre.roundTo(places: 1)
        yieldRecord.fieldName = (nameTextField.text != "Tap to enter field name") ? nameTextField.text : ""
        yieldRecord.timestamp = self.date
        yieldRecord.locationLatitude = 43.0
        yieldRecord.locationLongitude = -98.0
        
        //  save data record to the context
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        print("cancel button was pressed...")
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveYieldDataSegue"
        {
            let controller = segue.destination as! SaveYieldViewController
            controller.yieldModel = self.yieldModel
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
