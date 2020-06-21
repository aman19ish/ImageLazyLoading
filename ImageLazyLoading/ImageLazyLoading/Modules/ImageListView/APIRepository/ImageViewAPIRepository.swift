//
//  ImageViewAPIRepository.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

class ImageViewAPIRepository {
    // MARK: - Properties
    private let sessionProvider = URLSessionProvider()
    
    // MARK: - API Call's
    func getImageList(params: [String: String], completion: ((_ imageListModel: ImageListModel?,
        _ error: String?) -> Void)?) {
        
        sessionProvider.request(type: ImageListModel.self,
                                service: ImageListViewService.getImages(params: params),
                                success: { imageListModel in
                                    
                                    completion?(imageListModel, nil)
        }) { error in
            completion?(nil, error?.localizedDescription ?? "unknown")
        }
    }
    
}
