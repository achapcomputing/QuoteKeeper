//
//  SessionStore.swift
//  QK
//
//  Created by Ashlyn Chapman on 4/3/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class SessionStore: ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                // if we don't have a user, set our session to nil
                print("No user")
                self.session = nil
            }
        }
    }
    
    func register(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        //Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        // create user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if err != nil {
                print("Error creating user")
            } else {
                print("Created user")
                // creates user successfully, stores user info
//                let db = Firestore.firestore()
//                db.collection("users").addDocument(data: [
//                    "first name" : firstName,
//                    "last name" : lastName,
//                    "uid" : result!.user.uid
//                ]) { (error) in
//                    if error != nil {
//                        self.showError("Error saving user data")
//                    }
//                }
                
            }
        }
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // additional methods (sign up, sign in) will go here
}
//struct SessionStore_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionStore()
//    }
//}

class User {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}

struct SessionStore_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
