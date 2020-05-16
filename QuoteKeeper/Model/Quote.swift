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
	var docID: String
    var uid: String
	
    init(quote: String, source: String, docID: String, uid: String) {
		self.quote = quote
		self.source = source
		self.docID = docID
        self.uid = uid
	}
	
	override init() {
		self.quote = "quote"
		self.source = "source"
		self.docID = "docID"
        self.uid = "uid"
	}
	
}
