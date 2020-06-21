//
//  UserDeaultHandler.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func getImageSearchSuggestedResult() -> [AutoSuggestionModel]? {
        if let data = kUserDefault.object(forKey: UserDefaultKeys.kSearchAutoSuggestion.rawValue) as? Data {
            let decoder = JSONDecoder()
            let arrayAutoSuggestionModel = try? decoder.decode([AutoSuggestionModel].self, from: data)
            return arrayAutoSuggestionModel?.reversed()
        }
        return nil
        
        
    }
    
    static func addSuccessfullSearchString(searchString: String) {
        var array = [AutoSuggestionModel]()
        if let arraySearchAutoSuggestion = getImageSearchSuggestedResult() {
            array = arraySearchAutoSuggestion.reversed()
        }
        let autoSuggestionModel = AutoSuggestionModel(successfullSearchString: searchString)

        if array.contains(autoSuggestionModel), let index = array.firstIndex(of: autoSuggestionModel) {
            array.remove(at: index)
        }
        array.append(autoSuggestionModel)
        if array.count > kSuccessfullSearchMaxResult {
            array.removeFirst()
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            kUserDefault.set(encoded, forKey: UserDefaultKeys.kSearchAutoSuggestion.rawValue)
        }
        kUserDefault.synchronize()
        
    }
    
}
