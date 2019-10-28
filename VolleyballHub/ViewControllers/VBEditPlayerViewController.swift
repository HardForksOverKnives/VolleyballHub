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
    @IBOutlet weak var secondStrongestPositionPickerView: UIPickerView!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var playerToEdit: VBPlayerMO?
    
    var name: String?
    var jerseyNumber: Int16?
    var strongestPosition: String?
    var secondStrongestPosition: String?
    
    var editingIsLocked = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePickerViews()

        if let player = playerToEdit {
            initializeUIForPlayer(player: player)
        } else {
            initializeUIForNewPlayer()
        }
    }
    
    @IBAction func lockButtonPressed(_ sender: Any) {
        editingIsLocked = !editingIsLocked
        updateLockUI()
        
        if (editingIsLocked) {
            saveUpdatedPlayer()
        }
    }
    
    private func updateLockUI() {
        if (editingIsLocked) {
            lockButton.setImage(UIImage(named: "lock.fill"), for: .normal)
            for view in self.view.subviews {
                view.isUserInteractionEnabled = false
            }
            
        } else {
            lockButton.setImage(UIImage(named: "lock.open.fill"), for: .normal)
        }
        
        for view in self.view.subviews {
            view.isUserInteractionEnabled = !editingIsLocked
        }
        self.lockButton.isUserInteractionEnabled = true
    }
        
    private func initializeUIForNewPlayer() {
        strongestPosition = K.Positions.allValues.first
        secondStrongestPosition = K.Positions.allValues.first
        lockButton.isHidden = true
    }
    
    private func initializeUIForPlayer(player: VBPlayerMO) {
        name = player.name
        nameTextField.text = player.name!
        jerseyNumber = player.number
        jerseyNumberTextField.text = String(player.number)
        strongestPosition = player.position1
        secondStrongestPosition = player.position2
        
        if let row = K.Positions.allValues.firstIndex(of: player.position1!) {
            strongestPositionPickerView.selectRow(row, inComponent: 0, animated: false)
        }
        if let row = K.Positions.allValues.firstIndex(of: player.position2!) {
            secondStrongestPositionPickerView.selectRow(row, inComponent: 0, animated: false)
        }
        
        saveButton.isHidden = true
        updateLockUI()
    }
    
    private func initializePickerViews() {
        self.strongestPositionPickerView.delegate = self
        self.strongestPositionPickerView.dataSource = self
        self.secondStrongestPositionPickerView.delegate = self
        self.secondStrongestPositionPickerView.dataSource = self
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
        resignAttention()
        
        if (validatePlayerData() == false) {
            showSimpleAlert(title: "Error", body: "Please enter all player information.")
        } else {
            if (VBTeamManager.addPlayerToCurrentTeam(name: name!, strongestPosition: strongestPosition!, secondStrongestPosition: secondStrongestPosition!, number: jerseyNumber!, container: container!) == true) {
                self.navigationController?.popViewController(animated: true)
            } else {
                showSimpleAlert(title: "Error", body: "There was a problem saving the player")
            }
        }
    }
    
    private func saveUpdatedPlayer() {
        resignAttention()
        
        if (validatePlayerData() == false) {
            showSimpleAlert(title: "Error", body: "Please enter all player information.")
        }
        else if let player = playerToEdit {
            player.name = name!
            player.number = jerseyNumber!
            player.position1 = strongestPosition!
            player.position2 = secondStrongestPosition!
            self.container?.saveContext()
        }
    }
    
    private func validatePlayerData() -> Bool {
        var dataIsValid = false
        
        switch (name, strongestPosition, secondStrongestPosition, jerseyNumber) {
        case let (.some, .some(strongestPosition), .some(secondStrongestPosition), .some):
            if (strongestPosition != secondStrongestPosition) {
                dataIsValid = true
            }
        default:
            break
        }
        
        return dataIsValid
    }
    
    private func resignAttention() {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let position = K.Positions.allValues[row]
        if (pickerView == strongestPositionPickerView) {
            strongestPosition = position
        } else if (pickerView == secondStrongestPositionPickerView) {
            secondStrongestPosition = position
        }
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
