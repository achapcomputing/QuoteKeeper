//
//  RootTabView.swift
//  QK
//
//  Created by Ashlyn Chapman on 4/2/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    
    @State var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection) {
            QuoteList()
                .tabItem {
                    Image(systemName: "text.quote")
                    Text("Quotes")
                }
                .tag(0)
            //ProfileHost()
            ProfileLogin()
                .environmentObject(SessionStore())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
                .tag(1)
        }
        .accentColor(Color("Blue"))
        
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
        .environmentObject(UserData())
    }
}
