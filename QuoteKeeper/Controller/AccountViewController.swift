//
//  MoreViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/23/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class AccountViewController: UIViewController, FUIAuthDelegate {

	var authUI: FUIAuth?
	
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func signUpButtonTouched(_ sender: Any) {
        
    }
    
    @IBOutlet weak var loginButton: UIButton!
	@IBAction func loginButtonTouched(_ sender: Any) {
		// no user is logged in
//		if Auth.auth().currentUser == nil {
//			if let authVC = authUI?.authViewController() {
//				present(authVC, animated: true, completion: nil)
//			}
//		}
//		else {
//			do {
//				try Auth.auth().signOut()
//				self.loginButton.setTitle("Login", for: .normal)
//			}
//			catch {}
//		}
	}
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
		authUI = FUIAuth.defaultAuthUI()
		authUI?.delegate = self
		// TODO: Add Facebook and Google Auth (remember to add pods)
		let providers: [FUIAuthProvider] = [] // enable for Google, Facebook, etc
		self.authUI?.providers = providers
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
	func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
		// user is signed in, no errors occured
		if error == nil {
			loginButton.setTitle("Logout", for: .normal)
		}
	}

}
