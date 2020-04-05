//
//  RegisterView.swift
//  QK
//
//  Created by Ashlyn Chapman on 4/3/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct RegisterView : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    @EnvironmentObject var session: SessionStore

    func register() {
        loading = true
        error = false
        session.register(email: email, password: password) { (result, error) in
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
            TextField("First Name", text: $email)
                .padding()
            TextField("Last Name", text: $email)
                .padding()
            TextField("Email Address", text: $email)
                .padding()
            SecureField("Password", text: $password)
                .padding()
            Button(action: register) {
                Text("Register")
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(SessionStore())
    }
}
