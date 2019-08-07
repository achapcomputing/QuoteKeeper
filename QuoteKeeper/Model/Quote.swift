//
//  Quote.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 8/7/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import Foundation

class Quote: NSObject {
	
	var quote: String
	var source: String?
	
	init(quote: String, source: String) {
		self.quote = quote
		self.source = source
	}
	
	override init() {
		self.quote = "quote"
		self.source = "source"
	}
	
}

extension Quote {
	
	static var data: [Quote] {
		let yoda = Quote(quote: "Do or do not; there is no try", source: "Yoda")
		let darthV = Quote(quote: "I am your father", source: "Darth Vader")
		return [yoda, darthV]
	}
}
