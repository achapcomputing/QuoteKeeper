//
//  QuoteList.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct QuoteList: View {
    
    var body: some View {
        
        NavigationView {
            
            List(quoteData) { quote in
                NavigationLink(destination: QuoteDetail(quote: quote)) {
                    QuoteRow(quote: quote)
                }
            }
            .navigationBarTitle(Text("Quotes"))
        
        }
        
    }
}

struct QuoteList_Previews: PreviewProvider {
    static var previews: some View {
        QuoteList()
    }
}
