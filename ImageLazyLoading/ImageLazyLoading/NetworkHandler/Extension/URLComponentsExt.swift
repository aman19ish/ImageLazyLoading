//
//  URLComponentsExt.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

extension URLComponents {
    
    init?(service: ServiceProtocol) {
        
        guard let url = URL(string: service.completeUrlString)
        else {
            fatalError("URL is not correct")
        }
        //let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)
        
        guard case let .requestParameters(parameters) = service.task,
                   service.parametersEncoding == .url
        else { return }
        
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
