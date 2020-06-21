//
//  AutoSuggestionViewModel.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

class AutoSuggestionViewModel: NSObject {
    
    // MARK: - Properties
    private var arrayModel: [AutoSuggestionModel]?
    
    // MARK: - Initilizer
    override init() {
        super.init()
    }
    
    func getSuggestedResult(completion: (() -> ())) {
        if let arrayAutosuggestionModel = UserDefaults.getImageSearchSuggestedResult(), arrayAutosuggestionModel.count > 0 {
            arrayModel = arrayAutosuggestionModel
        }
        completion()
    }
    
}

// MARK: - TableView Helper Methods
extension AutoSuggestionViewModel {
    func getNumberOfSection() -> Int {
        return 1
    }
    
    func getNumberOfRaws(in section: Int) -> Int {
        return arrayModel?.count ?? 0
    }
    
    func getAutoSuggestionModel(at indexPath: IndexPath) -> AutoSuggestionModel? {
        return arrayModel?[indexPath.row]
    }
    
}
