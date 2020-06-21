//
//  ImageListViewService.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

enum ImageListViewService: ServiceProtocol {
    case getImages(params: [String: String])
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
    var task: Task {
        switch self {
        case let .getImages(params):
            var allParams = [String: String]()
            allParams["key"] = "17130117-33d88aea8e7ee88b03e166199"
            allParams.merge(dictionary: params)
            return .requestParameters(allParams)
        }
    }
    
}
