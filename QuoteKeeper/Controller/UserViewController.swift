//
//  UserViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 5/15/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase
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
        getUser()
        // Do any additional setup after loading the view.
    }
    
    func getUser() {
        let fstore = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        print("UID + \(uid!)")
        let docRef = fstore.collection("users").document("user-\(uid!)")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? ""
                print("Document data: \(dataDescription)")
//                print(document.data()!["first name"]!)
                let name = document.data()!["first name"]! as! String
                self.nameLabel.text = "Welcome, \(name)"
            } else {
                print("Document does not exist")
            }
        }
    }

}
