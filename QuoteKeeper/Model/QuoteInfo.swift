//
//  QuoteInfo.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import Foundation

class QuoteInfo: NSObject {

	let medium: String?
	let char: String?
	let pageNum: String?
	
	override init() {
		self.medium = "medium"
		self.char = "char"
		self.pageNum = ""
	}
	
	// TODO: Create inits when missing parts of info (no page, etc)
	
	init(medium: String, char: String, pageNum: String) {
		self.medium = medium
		self.char = char
		self.pageNum = pageNum
		super.init()
	}
	
}
