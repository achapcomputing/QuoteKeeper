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
			Text(quote.text)
			Spacer()
//			if quote.isFavorite {
//				Image(systemName: "star.fill")
//					.imageScale(.medium)
//					.foregroundColor(.yellow)
//			}
		}
		
    }
	
}

struct QuoteCell_Previews: PreviewProvider {
    static var previews: some View {
		QuoteRow(quote: quoteData[0])
    }
}
