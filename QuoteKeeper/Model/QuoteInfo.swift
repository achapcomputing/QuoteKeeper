//
//  QuoteInfo.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import Foundation

class QuoteInfo: NSObject {

	let title: String?
	let char: String?
	let pageNum: String?
	
	override init() {
		self.title = "title"
		self.char = "char"
		self.pageNum = "-1"
	}
	
	// TODO: Create inits when missing parts of info (no page, etc)
	
	init(title: String, char: String, pageNum: String) {
		self.title = title
		self.char = char
		self.pageNum = pageNum
		super.init()
	}
	
}
