//
//  AccountViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 5/15/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
        //nameLabel.text = "Welcome!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    private lazy var UserVC: UserViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Load Storyboard
        var viewController = storyboard.instantiateViewController(withIdentifier: "UserVC") as! UserViewController // Instantiate View Controller
        self.add(asChildViewController: viewController) // Add View Controller as Child View Controller
        return viewController
    }()

    private lazy var SignInVC: SignInViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Load Storyboard
        var viewController = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController // Instantiate View Controller
        self.add(asChildViewController: viewController) // Add View Controller as Child View Controller
        return viewController
    }()
    
     private func updateView() {
        Auth.auth().addStateDidChangeListener { auth, user in
          if let user = user {
            self.remove(asChildViewController: self.SignInVC)
            self.add(asChildViewController: self.UserVC)
            print("User: \(user)")
          } else {
            self.remove(asChildViewController: self.UserVC)
            self.add(asChildViewController: self.SignInVC)
          }
        }
//
//        if let currentUser = Auth.auth().currentUser {
//            remove(asChildViewController: SignInVC)
//            add(asChildViewController: UserVC)
//        } else {
//            remove(asChildViewController: UserVC)
//            add(asChildViewController: SignInVC)
//        }
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }

}
