//
//  ImageListViewModel.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

class ImageListViewModel: NSObject {
    
    // MARK: - Properties
    private var model: ImageListModel?
    
    // MARK: - Initilizer
    override init() {
        super.init()
    }
    
    // MARK: - API Call's
    
}

// MARK: - Collection View Helper Methods
extension ImageListViewModel {
    func getNumberOfSection() -> Int {
        return 1
    }
    
    func getNumberOfRows() -> Int {
        return 10
        //return model?.imageDetailList?.count ?? 0
    }
    
}
