//
//  QuoteDetail.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import SwiftUI

struct QuoteDetail: View {
	
	var quote: Quote
	
    var body: some View {
		
        VStack(alignment: .leading) {
			
			Text(quote.text)
			Text(quote.source)
            
        }
        .navigationBarTitle(Text(quote.source), displayMode: .inline)
		
    }
}

struct QuoteDetail_Previews: PreviewProvider {
    static var previews: some View {
		QuoteDetail(quote: quoteData[0])
    }
}
