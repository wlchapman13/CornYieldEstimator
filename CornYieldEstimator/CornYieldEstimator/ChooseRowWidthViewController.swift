//
//  ChooseRowWidthViewViewController.swift
//  CornYieldEstimator
//
//  Created by WILLIAM CHAPMAN on 7/24/17.
//  Copyright © 2017 WILLIAM CHAPMAN. All rights reserved.
//

import UIKit

class ChooseRowWidthViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    //  reference to the Yield Model
    var yieldModel = YieldModel()
    
    @IBOutlet weak var rowWidthPicker: UIPickerView!
    
    let pickerData = ["16 inches", "17 inches", "18 inches", "19 inches", "20 inches", "21 inches", "22 inches", "23 inches", "24 inches", "25 inches", "26 inches", "27 inches", "28 inches", "29 inches", "30 inches", "31 inches", "32 inches", "33 inches", "34 inches", "35 inches", "36 inches"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("inside viewDidAppear:ChooseRowWidthViewController ... yieldModel.rowsPerField is \(yieldModel.rowsPerField)")
        
        let pickerIndex = Int(yieldModel.rowsPerField)-16
        rowWidthPicker.selectRow(pickerIndex, inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //  when the picker is rotated, set the models value to the picker value
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yieldModel.rowsPerField = Double(row + 16)
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
