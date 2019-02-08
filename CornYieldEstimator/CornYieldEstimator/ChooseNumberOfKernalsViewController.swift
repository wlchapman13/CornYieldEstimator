//
//  ChooseNumberOfKernalsViewController.swift
//  CornYieldEstimator
//
//  Created by WILLIAM CHAPMAN on 7/27/17.
//  Copyright © 2017 WILLIAM CHAPMAN. All rights reserved.
//

import UIKit

class ChooseNumberOfKernalsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var numberInColumnPicker: UIPickerView!
    
    @IBOutlet weak var numberInRowPicker: UIPickerView!
    
    //  reference to the Yield Model
    var yieldModel = YieldModel()
    var earNumber = 0
    
    
    var rowPickerData : [String] = []
    var columnPickerData : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("inside ChooseNumberOfKernalsViewController...")
        print("earNumber is \(earNumber)")
        
        // Do any additional setup after loading the view.
        
        //  initialize the array for columnPickerData
        for numInColumn in 6...36 {
            columnPickerData.append("\(numInColumn) kernals")
        }
        
        //  initialize the array for rowPickerData
        for numInRow in 12...60 {
            rowPickerData.append("\(numInRow) kernals")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("inside viewDidAppear:ChooseRowWidthViewController ... yieldModel.rowsPerField is \(yieldModel.rowsPerField)")
        print("earNumber = \(earNumber)")
        
        let columnPickerIndex = Int(yieldModel.kernalsInColumn[earNumber])-6
        print("columnPickerIndex is \(columnPickerIndex)")
        
        numberInColumnPicker.selectRow(columnPickerIndex, inComponent: 0, animated: true)
        
        let rowPickerIndex = Int(yieldModel.kernalsInRow[earNumber])-12
        print("rowPickerIndex is \(rowPickerIndex)")
        
        numberInRowPicker.selectRow(rowPickerIndex, inComponent: 0, animated: true)
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
            return columnPickerData.count
        } else {
            return rowPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            print("setting titles: \(columnPickerData[row])")
            return columnPickerData[row]
        } else {
            return rowPickerData[row]
        }
    }
    
    //  when the picker is rotated, set the models value to the picker value
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            yieldModel.kernalsInColumn[earNumber] = Double(row + 6)
        } else {
            yieldModel.kernalsInRow[earNumber] = Double(row + 12)
        }
        
        print("All Kernals In Row: \(yieldModel.kernalsInRow)")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
