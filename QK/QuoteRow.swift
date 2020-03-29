//
//  QuoteCell.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct QuoteRow: View {
	
	var quote: Quote
	
    var body: some View {
        
		HStack {
            
            VStack(alignment: .leading) {
                
                Text(quote.text)
                    .font(.body)
                Text(quote.source)
                    .font(.caption)
                
            }
            .padding(7)
                        
            
            Spacer()
//			if quote.isFavorite {
//				Image(systemName: "star.fill")
//					.imageScale(.medium)
//					.foregroundColor(.yellow)
//			}
            
		}
        //.border(Color.gray, width: 3)
        
		
    }
	
}

struct QuoteCell_Previews: PreviewProvider {
    static var previews: some View {
		//QuoteRow()
        QuoteRow(quote: quoteData[0])
    }
}
