//
//  VBBaseViewController.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/15/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBBaseViewController: UIViewController {
    typealias EmptyMethodHandler = () -> Void
    
    var container: VBPersistentContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showSimpleAlert(title: String, body: String, buttonText: String = "OK", completion: EmptyMethodHandler? = nil) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        if let f = completion {
            alert.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: {action in f()}))
        } else {
            alert.addAction(UIAlertAction(title: buttonText, style: .cancel))
        }
        self.present(alert, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? VBBaseViewController {
            nextVC.container = container
        }
    }
 

}
