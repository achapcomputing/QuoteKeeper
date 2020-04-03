//
//  UserData.swift
//  QK
//
//  Created by Ashlyn Chapman on 3/28/20.
//  Copyright © 2020 Ashlyn Chapman. All rights reserved.
//

import Foundation
import Combine

final class UserData: ObservableObject {
    
    @Published var showFavoritesOnly = false
    @Published var quotes = quoteData
    @Published var profile = Profile.default
    @Published var medium: Medium = .book
    
}
