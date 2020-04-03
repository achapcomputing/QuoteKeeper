//
//  Quote.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import Foundation
import Combine

struct Quote: Hashable, Decodable, Identifiable {// codable in ex
	
	var id: Int
	var text: String
	var source: String
	var medium: String // TODO: change to Medium enum
//    var notes: String = ""
//	var pageNum: Int?
//	var timeStamp: Int?
	
	var isFavorite: Bool
	
//	enum Medium: String, CaseIterable, Codable, Hashable {
//		case book = "Book" // pagenum
//		case poem = "Poem" // collection, poem, pagenum
//		case song = "Song" // timestamp
//		case movie = "Movie" // timestamp
//		case tv = "TV Show" // season, episode, timestamp
////      case proverb
////      case friend
////      case other
//	}
	
}

let testQuote = Quote(id: 101,
                  text: "I am still learning how to go back and reread my own chapters without feeling like I want to set all of my pages on fire.",
                  source: "EV Rogina",
                  medium: "Quote",
                  isFavorite: false)

enum Medium: String {

    case book = "Book" // pagenum
    case poem = "Poem" // collection, poem, pagenum
    case song = "Song" // timestamp
    case movie = "Movie" // timestamp
    
    /// a formatted string version of the size
    func formatted() -> String {
        var mediumString = ""
        switch self{
        case .book:
            mediumString = "Book"
        case .poem:
            mediumString = "Poem"
        case .song:
            mediumString = "Song"
        case .movie:
            mediumString = "Movie"
        }
        return mediumString
    }
}
