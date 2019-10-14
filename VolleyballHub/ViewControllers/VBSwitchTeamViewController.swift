//
//  VBSwitchTeamViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 10/9/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBSwitchTeamViewController: VBBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var teamNames: [String] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VBMenuTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: K.TableView.SwitchTeam.reuseID) as! VBMenuTableViewCell
        
        cell.label.text = teamNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VBTeamManager.setCurrentTeam(name: teamNames[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNames = VBTeamManager.allTeamNames(context: container!.viewContext)

        tableView.delegate = self
        tableView.dataSource = self
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
