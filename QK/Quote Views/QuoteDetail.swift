//
//  QuoteDetail.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct QuoteDetail: View {
	
    @EnvironmentObject var userData: UserData
	var quote: Quote
    
    var quoteIndex: Int {
        userData.quotes.firstIndex(where: { $0.id == quote.id })!
    }
	
    var body: some View {
		
        HStack {
            VStack(alignment: .leading) {
                
                Text(quote.text)
                Text(quote.source)
                Text(quote.medium)
                
                Button(action: {
                    self.userData.quotes[self.quoteIndex].isFavorite.toggle()
                }) {
                    if self.userData.quotes[self.quoteIndex].isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(Color.gray)
                    }
                }
                
            }
            .padding(7)
            .navigationBarTitle(Text(quote.source), displayMode: .inline)
            Spacer()
        }
		
    }
}

struct QuoteDetail_Previews: PreviewProvider {
    static var previews: some View {
		QuoteDetail(quote: quoteData[0])
        .environmentObject(UserData())
    }
}
