//
//  UserViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 5/15/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBAction func logoutTouched(_ sender: Any) {
       if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            }
            catch {
            }
        }
        if Auth.auth().currentUser == nil {
            print("sign out")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Welcome \(Auth.auth().currentUser?.email)"
        // Do any additional setup after loading the view.
    }

}
