//
//  VBEditPlayerViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 10/13/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBEditPlayerViewController: VBBaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jerseyNumberTextField: UITextField!
    @IBOutlet weak var strongestPositionPickerView: UIPickerView!
    @IBOutlet weak var secondStrongestPositionPicker: UIPickerView!
    
    var name: String?
    var jerseyNumber: Int16?
    var strongestPosition: String?
    var secondStrongestPosition: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.strongestPositionPickerView.delegate = self
        self.strongestPositionPickerView.dataSource = self
        self.secondStrongestPositionPicker.delegate = self
        self.secondStrongestPositionPicker.dataSource = self
    }
    
    @IBAction func nameTextFieldPrimaryActionTriggered(_ sender: Any) {
        if (nameTextField.text!.count > 0) {
            nameTextField.resignFirstResponder()
        }
    }
    @IBAction func nameTextFieldEditingDidEnd(_ sender: Any) {
        if (nameTextField.text!.count > 0) {
            name = nameTextField.text
            jerseyNumberTextField.becomeFirstResponder()
        } else {
            name = nil
        }
    }
    
    @IBAction func jerseyNumberTextFieldPrimaryActionTriggered(_ sender: Any) {
        if (jerseyNumberTextField.text!.count > 0) {
            jerseyNumberTextField.resignFirstResponder()
        }
    }
    
    @IBAction func jerseyNumberTextFieldEditingDidEnd(_ sender: Any) {
        var success = false
        if let num = Int16(jerseyNumberTextField.text!) {
            if (num >= 0 && num <= 99) {
                jerseyNumber = num
                jerseyNumberTextField.resignFirstResponder()
                success = true
            }
        }
        
        if (!success) {
            resetJerseyNumberUI()
        }
    }
    
    private func resetJerseyNumberUI() {
        jerseyNumber = nil
        jerseyNumberTextField.text = ""
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        VBTeamManager.addPlayerToCurrentTeam(name: "Marlee", strongestPosition: K.Positions.Outside.rawValue, secondStrongestPosition: K.Positions.Opposite.rawValue, number: 21, container: container!)
    }
    
    
    // MARK: PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.Positions.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return K.Positions.allValues[row]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
