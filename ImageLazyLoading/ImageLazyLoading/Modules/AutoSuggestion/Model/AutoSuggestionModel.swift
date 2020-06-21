//
//  AutoSuggestionModel.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

struct AutoSuggestionModel: Codable, Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.successfullSearchString == rhs.successfullSearchString
    }
    let successfullSearchString: String
}
