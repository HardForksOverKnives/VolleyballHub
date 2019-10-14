//
//  VBMenuViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/15/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBMenuViewController: VBBaseViewController, UITableViewDelegate, UITableViewDataSource {

    typealias EmptyMethodHandler = () -> Void

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var createTeamButton: UIButton!
    
    private var menuIsVisible = false
    private var menuIsAnimating = false
    
    var cellData: [VBTableViewCellInfo] = []
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadState()
        tableView.reloadData()
    }
    
    func loadState() {
        if let currentTeam = VBTeamManager.getCurrentTeam(context: container!.viewContext) {
            loadTeamState(team: currentTeam)
        } else {
            loadNoTeamState()
        }
    }
    
    func loadTeamState(team: VBTeamMO) {
        self.teamNameLabel.text = team.name
        self.createTeamButton.isHidden = true
        
        cellData = [VBTableViewCellInfo(reuseID: K.TableView.Menu.reuseID, text: "Switch Teams", imageName: "hamburger", segueName: K.TableView.Menu.SegueID.menu_switchTeam),
                    VBTableViewCellInfo(reuseID: K.TableView.Menu.reuseID, text: "Edit Roster", imageName: "hamburger", segueName: K.TableView.Menu.SegueID.menu_editRoster)]
    }
    
    func loadNoTeamState() {
        self.createTeamButton.isHidden = false
        
        cellData = [VBTableViewCellInfo(reuseID: K.TableView.Menu.reuseID, text: "Create Team", imageName: "hamburger", segueName:K.TableView.Menu.SegueID.menu_createTeam)]
    }
    
    @IBAction func createTeamButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: K.TableView.Menu.SegueID.menu_createTeam, sender: self)
    }
    
    // MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:VBMenuTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: K.TableView.Menu.reuseID) as! VBMenuTableViewCell
        
        let cellInfo = self.cellData[indexPath.row]
        cell.label.text = cellInfo.text
        if let imageName = cellInfo.imageName {
            cell.icon.image = UIImage(named: imageName)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let segue = cellData[indexPath.row].segueName {
            self.performSegue(withIdentifier: segue, sender: self)
        }
        else if let f = cellData[indexPath.row].function {
            f()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    // MARK: Sliding Menu
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        if (menuIsVisible) {
            hideMenu(animated: true)
        } else {
            showMenu(animated: true)
        }
    }
    
    func showMenu(animated: Bool) {
        if (!menuIsVisible && !menuIsAnimating) {
            leadingConstraint.constant = 0
            if (animated) {
                animateMenu { self.menuIsVisible = true }
            } else {
                view.layoutSubviews()
                menuIsVisible = true
            }
        }
    }
    
    func hideMenu(animated: Bool) {
        if (menuIsVisible && !menuIsAnimating) {
            leadingConstraint.constant = -300
            if (animated) {
                animateMenu { self.menuIsVisible = false }
            } else {
                view.layoutSubviews()
                menuIsVisible = false
            }
        }
    }
    
    func animateMenu(completion: @escaping EmptyMethodHandler) {
        if (!menuIsAnimating) {
            menuIsAnimating = true
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }) { (animationComplete) in
                self.menuIsAnimating = false
                completion()
            }
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        hideMenu(animated: true)
    }
}
