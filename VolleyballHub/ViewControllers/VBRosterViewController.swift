//
//  VBRosterViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 10/24/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBRosterViewController: VBBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var rosterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Roster"
        let addPlayerButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayerPressed))
        self.navigationItem.rightBarButtonItems = [addPlayerButton]
    }
    
    @objc func addPlayerPressed() {
        self.performSegue(withIdentifier: K.SegueID.roster_editPlayer, sender: self)
    }
    
    private func currentRoster() -> [VBPlayerMO]? {
        if let players = VBTeamManager.playersOnCurrentTeamByNumber(context: self.container!.viewContext) {
            return players
        } else {
            return nil
        }
    }
    
    // MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsInSection = 0
        if let playersCount = VBTeamManager.getCurrentTeam(context: self.container!.viewContext)?.players?.count {
            rowsInSection = playersCount
        }
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:VBPlayerTableViewCell = self.rosterTableView.dequeueReusableCell(withIdentifier: K.TableView.Roster.reuseID) as! VBPlayerTableViewCell
        
        if let players = currentRoster() {
            cell.setUpForPlayer(player: players[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
