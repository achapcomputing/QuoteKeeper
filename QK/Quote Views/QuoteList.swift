//
//  QuoteList.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct QuoteList: View {
    
    @EnvironmentObject var userData: UserData
    @State var showingAdd = false
    @State var showingFilter = false
    @State private var searchTerm: String = ""
    
    var filterButton: some View {
        Button(action: { self.showingFilter.toggle() }) {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .accessibility(label: Text("Add Filter"))
                .padding()
        }
    }
    
    var addButton: some View {
        Button(action: { self.showingAdd.toggle() }) {
            Image(systemName: "plus")
                .imageScale(.large)
                .accessibility(label: Text("Add Quote"))
                .padding()
        }
    }
    
    var body: some View {
            
        VStack {
            NavigationView {
                
                List {
                    
//                    HStack {
//
//                        SearchBar(text: $searchTerm)
//                        Spacer()
//                        Toggle(isOn: $userData.showFavoritesOnly) {
//                            Text("Favorites")
//                        }
//
//                    }
                    
                    Section {
                        ForEach(userData.quotes) { quote in
                            
                            if !self.userData.showFavoritesOnly || quote.isFavorite {
                                NavigationLink(destination: QuoteDetail(quote: quote)) {
                                    QuoteRow(quote: quote)
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
                
                .navigationBarTitle(Text("Quotes"))
                .navigationBarItems(trailing:
                    HStack {
                        filterButton
                        addButton
                    }
                )
                .sheet(isPresented: $showingAdd) {
                    QuoteAdd(showingAdd: self.$showingAdd).environmentObject(UserData())
                }
//                .sheet(isPresented: $showingFilter) {
//                    QuoteFilter()
//                }
            
            }
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        userData.quotes.remove(atOffsets: offsets)
    }
}

struct QuoteList_Previews: PreviewProvider {
    static var previews: some View {
        QuoteList()
            .environmentObject(UserData())
    }
}
