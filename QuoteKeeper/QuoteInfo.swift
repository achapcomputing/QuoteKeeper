//
//  QuoteInfo.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import Foundation

class QuoteInfo: NSObject {
	
	let quote: String
	let source: String?
	let title: String?
	let pageNum: String?
	
	override init() {
		self.quote = "quote"
		self.source = "source"
		self.title = "title"
		self.pageNum = "-1"
	}
	
	// TODO: Create inits when missing parts of info (no page, etc)
	
	init(quote: String, source: String, title: String, pageNum: String) {
		self.quote = quote
		self.source = source
		self.title = title
		self.pageNum = pageNum
		super.init()
	}
	
}

extension QuoteInfo {
	
	static var data: [QuoteInfo] {
		let yoda = QuoteInfo(quote: "Do or do not; there is no try", source: "Yoda", title: "Star Wars", pageNum: "0")
		let darthV = QuoteInfo(quote: "I am your father", source: "Darth Vader", title: "Star Wars Empire Strikes Back", pageNum: "1")
		return [yoda, darthV]
	}
	
}
