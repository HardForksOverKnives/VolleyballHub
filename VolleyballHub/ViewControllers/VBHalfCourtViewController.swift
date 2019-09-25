//
//  VBHalfCourtViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/14/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBHalfCourtViewController: UIViewController {
    
    @IBOutlet weak var topAttackArea: UIView!
    @IBOutlet weak var topAttackLine: UIView!
    @IBOutlet weak var bottomAttackArea: UIView!
    @IBOutlet weak var bottomAttackLIne: UIView!
    
    var isTopSide = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (isTopSide) {
            topAttackLine.isHidden = true
            topAttackArea.isHidden = true
        } else {
            bottomAttackLIne.isHidden = true
            bottomAttackArea.isHidden = true
        }
        
        
    }
}
