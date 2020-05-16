//
//  SignInViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/23/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class SignInViewController: UIViewController, FUIAuthDelegate {

	var authUI: FUIAuth?
	
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func signUpButtonTouched(_ sender: Any) {
        
    }
    
    @IBOutlet weak var loginButton: UIButton!
	@IBAction func loginButtonTouched(_ sender: Any) {

	}
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
		authUI = FUIAuth.defaultAuthUI()
		authUI?.delegate = self
		// TODO: Add Facebook and Google Auth (remember to add pods)
		let providers: [FUIAuthProvider] = [] // enable for Google, Facebook, etc
		self.authUI?.providers = providers
    }
	
	func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
		// user is signed in, no errors occured
		if error == nil {
			loginButton.setTitle("Logout", for: .normal)
            signUpButton.isHidden = true
		}
	}
    
}
