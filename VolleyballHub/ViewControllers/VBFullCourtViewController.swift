//
//  ViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/13/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

class VBFullCourtViewController: UIViewController {

    @IBOutlet weak var side1Container: UIView!
    @IBOutlet weak var side2Container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let newAttackVerticalConstraint = side1attackLineVerticalConstraint.constraintWithMultiplier(0.6666)
//        view.removeConstraint(side1attackLineVerticalConstraint)
//        view.addConstraint(newAttackVerticalConstraint)
//        view.layoutIfNeeded()
//        side1attackLineVerticalConstraint = newAttackVerticalConstraint
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "side1EmbedSegue" {
            if let side1ViewController = segue.destination as? VBHalfCourtViewController {
                side1ViewController.isTopSide = true
            }
        }
    }
}

