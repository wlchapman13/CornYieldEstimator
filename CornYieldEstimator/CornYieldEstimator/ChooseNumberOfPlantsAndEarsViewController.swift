//
//  ChooseNumberOfPlantsAndEarsViewController.swift
//  CornYieldEstimator
//
//  Created by WILLIAM CHAPMAN on 7/26/17.
//  Copyright © 2017 WILLIAM CHAPMAN. All rights reserved.
//

import UIKit

class ChooseNumberOfPlantsAndEarsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var numberOfPlantsPicker: UIPickerView!
    
    @IBOutlet weak var numberOfEarsPicker: UIPickerView!
    
    //  reference to the Yield Model
    var yieldModel = YieldModel()
    
    
    let plantPickerData = ["15 plants", "16 plants", "17 plants", "18 plants", "19 plants", "20 plants", "21 plants", "22 plants", "23 plants", "24 plants", "25 plants", "26 plants", "27 plants", "28 plants", "29 plants", "30 plants", "31 plants", "32 plants", "33 plants", "34 plants", "35 plants", "36 plants", "37 plants", "38 plants", "39 plants", "40 plants", "41 plants", "42 plants", "43 plants", "44 plants"]
    
    var earPickerData : [String] = []
    
//    let earPickerData = ["15 plants", "16 plants", "17 plants", "18 plants", "19 plants", "20 plants", "21 plants", "22 plants", "23 plants", "24 plants", "25 plants", "26 plants", "27 plants", "28 plants", "29 plants", "30 plants", "31 plants", "32 plants", "33 plants", "34 plants", "35 plants", "36 plants", "37 plants", "38 plants", "39 plants", "40 plants", "41 plants", "42 plants", "43 plants", "44 plants"]
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //  initialize the array for earPickerData
        for numEar in 15...44 {
            earPickerData.append("\(numEar) ears")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("inside viewDidAppear:ChooseRowWidthViewController ... yieldModel.rowsPerField is \(yieldModel.rowsPerField)")
        
        let plantPickerIndex = Int(yieldModel.numberOfPlantsInSample)-15
        print("plantPickerIndex is \(plantPickerIndex)")
        
        numberOfPlantsPicker.selectRow(plantPickerIndex, inComponent: 0, animated: true)
        
        let earPickerIndex = Int(yieldModel.numberOfEarsInSample)-15
        print("earPickerIndex is \(earPickerIndex)")

        numberOfEarsPicker.selectRow(earPickerIndex, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return self.plantPickerData.count
        } else {
            return self.earPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            print("setting titles: \(plantPickerData[row])")
            return plantPickerData[row]
        } else {
            return earPickerData[row]
        }
    }
    
    //  when the picker is rotated, set the models value to the picker value
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            yieldModel.numberOfPlantsInSample = Double(row + 15)
        } else {
            yieldModel.numberOfEarsInSample = Double(row + 15)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
