//
//  VBCreateTeamViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/16/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit
import CoreData

class VBCreateTeamViewController: VBBaseViewController {

    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var coachNameTextField: UITextField!
    
    var teamName: String?
    var coachName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let button1 = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .plain, target: self, action: Selector("action")) // action:#selector(Class.MethodName) for swift 3

        self.navigationItem.title = "Create Team"
    }
    

    @IBAction func teamNameTextFieldEditingDidEnd(_ sender: Any) {
        print("team name: " + teamNameTextField.text!)
        teamName = teamNameTextField.text!
    }
    @IBAction func coachNameTextFieldEditingDidEnd(_ sender: Any) {
        print("coach name: " + coachNameTextField.text!)
        coachName = coachNameTextField.text!
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        if (validateTextFields()) {
            saveTeam()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func validateTextFields() -> Bool {
        var passed = false
        
        if (teamName == nil) {
            showSimpleAlert(title: "Error", body: "A team name is required.")
        } else if (coachName == nil) {
            showSimpleAlert(title: "Error", body: "A coach is required.")
        } else {
            passed = true
        }
        
        return passed
    }
    
    func saveTeam() {
        let team = NSEntityDescription.insertNewObject(forEntityName: "VBTeam", into: container!.viewContext) as! VBTeamMO
        team.name = teamName
        team.coach = coachName
        container!.saveContext()
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
