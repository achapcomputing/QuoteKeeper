//
//  Quote.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import Foundation

struct Quote: Hashable, Identifiable, Decodable {// codable in ex
	
	var id: Int
	var text: String
	var source: String
	var medium: String // TODO: change to Medium enum
//	var pageNum: Int?
//	var timeStamp: Int?
	
	var isFavorite: Bool
	
	enum Medium: String, CaseIterable, Codable, Hashable {
		case book = "Book" // pagenum
		case poem = "Poem" // collection, poem, pagenum
		case song = "Song" // timestamp
		case movie = "Movie" // timestamp
		case tv = "TV Show" // season, episode, timestamp
	}
	
}
