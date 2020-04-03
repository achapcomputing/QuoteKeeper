//
//  QuoteAdd.swift
//  QK
//
//  Created by Ashlyn Chapman on 4/3/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct QuoteAdd: View {
    
    @EnvironmentObject var userdata: UserData
    @State var notes: String = ""
    @State var selectedMedium = 0
    @Binding var showingAdd: Bool
    
    let mediums: [Medium] = [.book, .poem, .song, .movie]
    
    var saveButton: some View {
        Button(action: {
            self.showingAdd.toggle()

        }) {
            Text("Save")
        }
    }
    
    var body: some View {
       
        VStack {
            
            NavigationView {
                Form {
                   // Section {
                    TextField("Quote", text: $notes)
                        Picker(selection: self.$userdata.medium, label: Text("Medium")) {
                            ForEach(self.mediums, id:\.self) { medium in
                                Text(medium.formatted()).tag(medium)
                            }
                        }
                        TextField("Source", text: $notes)
                        TextField("Notes", text: $notes)
                    //}
                }
                .navigationBarTitle("Add Quote")
                .navigationBarItems(trailing: saveButton)
//                .sheet(isPresented: $showingAdd) {
//                    QuoteList().environmentObject(UserData())
//                }

            }
            
//            Button("Add a quote!") {
//                self.showPopover = true
//            }.popover(isPresented: self.$showPopover, arrowEdge: .bottom) {
//
//            }
//            Picker(selection: self.$userdata.medium, label: Text("Medium")) {
//                ForEach(self.mediums, id:\.self) { medium in
//                    Text(medium.formatted()).tag(medium)
//                }
//            }
        }
        
    }
}

struct QuoteAdd_Previews: PreviewProvider {
    static var previews: some View {
        QuoteAdd(showingAdd: .constant(true))
            .environmentObject(UserData())
    }
}
