//
//  VBMenuViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/15/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBMenuViewController: VBBaseViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var menuIsVisible = false
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        if (!menuIsVisible) {
            leadingConstraint.constant = 0
        } else {
            leadingConstraint.constant = -300
        }
        menuIsVisible = !menuIsVisible
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    
    let cellData = [
        [ K.TableView.text: "Create Team!", K.TableView.imageName: "hamburger", K.TableView.reuseID: K.MenuTableView.menuCellReuseID ],
        [ K.TableView.text: "Create Team!", K.TableView.imageName: "hamburger", K.TableView.reuseID: K.MenuTableView.menuCellReuseID ],
        [ K.TableView.text: "Create Team!", K.TableView.imageName: "hamburger", K.TableView.reuseID: K.MenuTableView.menuCellReuseID ]
    ];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:VBMenuTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: K.MenuTableView.menuCellReuseID) as! VBMenuTableViewCell
        
        let cellInfo = self.cellData[indexPath.row]
        cell.label.text = cellInfo[K.TableView.text]
        cell.icon.image = UIImage(named: cellInfo[K.TableView.imageName]!)
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        self.performSegue(withIdentifier: K.SegueID.menu_createTeam, sender: self)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vbcreateteamvc")
//        self.navigationController?.pushViewController(vc!, animated: true)
//        self.show(vc!, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
