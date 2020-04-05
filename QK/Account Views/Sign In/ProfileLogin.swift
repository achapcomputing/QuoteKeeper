//
//  ProfileLogin.swift
//  QK
//
//  Created by Ashlyn Chapman on 4/3/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FBSDKLoginKit

struct ProfileLogin: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        Group {
            if (session.session != nil) {
                Text("Hello user!")
            } else {
                NavigationView {
                    VStack {
                        Spacer()

//                        Button(action: SocialLogin().attemptLoginGoogle, label: {
//                            //Image("ic_google").frame(width: 20, height: 20)
//                            Text("Login with Google")
//                        })
//                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
//                        .background(Color.white)
//                        .cornerRadius(8.0)
//                        .shadow(radius: 4.0)
                        
                        Button(action: signInFB, label: {
                            Text("Login with Facebook")
//                                Image("ic_facebook")
//                                    .foregroundColor(Color.white)
//                                    .frame(width: 20, height: 20)
                        })
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        //.background(Color("facebook"))
                        .cornerRadius(8.0)
                    
                        NavigationLink(destination: LoginEmailView()) {
                            Text("Login with Email")
                        }
                        .padding(20)
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                        }
                        .padding(20)
                        
                    }
                }.navigationBarTitle(Text("Login"))
            }
        }.onAppear(perform: getUser)
    
    }
    
    func getUser() {
        session.listen()
    }
    
    func signInFB() {
        SocialLogin().attemptLoginFb(completion: { result, error in

        })
    }
    
}

struct ProfileLogin_Previews: PreviewProvider {
    static var previews: some View {
        ProfileLogin().environmentObject(SessionStore())
    }
}
