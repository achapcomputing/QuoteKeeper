//
//  SignInView.swift
//  QK
//
//  Created by Ashlyn Chapman on 4/3/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct LoginEmailView : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    @EnvironmentObject var session: SessionStore

    func login() {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }

    var body: some View {
        VStack {
            TextField("Email Address", text: $email)
                .padding()
            SecureField("Password", text: $password)
                .padding()
            Button(action: login) {
                Text("Login")
            }
            .padding()
            if (error) {
                Text("Error")
                    .foregroundColor(Color.red)
            }
            Spacer()
        }
        .padding()
    }
}

struct LoginEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView().environmentObject(SessionStore())
    }
}
