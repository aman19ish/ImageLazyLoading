//
//  URLRequestExt.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(service: ServiceProtocol) {
        
        guard let urlComponents = URLComponents(service: service),
              let url = urlComponents.url
        else {
            fatalError("URL is not correct")
        }
        
        self.init(url: url)
        
        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        if case let .requestPlain(text) = service.task, text.count > 0 {
            httpBody = text.data(using: .utf8, allowLossyConversion: false)
        }

        guard case let .requestParameters(parameters) = service.task
        else { return }
        
        if service.parametersEncoding == .utf8 {
            // For Login
            let jsonString = parameters.reduce("") { "\($0)\($1.0)=\($1.1)&" }
            httpBody = jsonString.data(using: .utf8, allowLossyConversion: false)
        } else if service.parametersEncoding == .json {
            // For Sign Up
            httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
    }
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
