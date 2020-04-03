//
//  RootTabView.swift
//  QK
//
//  Created by Ashlyn Chapman on 4/2/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        
        TabView {
            QuoteList()
                .tabItem {
                    Image(systemName: "text.quote")
                    Text("Quotes")
                }
            ProfileHost()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
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
