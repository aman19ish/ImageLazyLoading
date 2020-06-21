//
//  URLSessionProvider.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

open class URLSessionProvider: ProviderProtocol {
    
    public init() {
        
    }
    
    open func request<T>(type: T.Type,
                         service: ServiceProtocol,
                         success: @escaping (T) -> (),
                         failure: @escaping (Error?) -> ()) where T: Codable {
        
        let request = URLRequest(service: service)
        
        print("REQUEST: \(request.url?.absoluteString ?? "")")
        print("HEADERS: \(request.allHTTPHeaderFields ?? [:])")
        print("QUERY PARAMS: \(request.url?.queryParameters ?? [:])")
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            debugPrint("anything")
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("RESPONSE: \(json)")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode >= ResponseStatusCode.successMinRange.rawValue,
                    statusCode <= ResponseStatusCode.successMaxRange.rawValue {
                    let decoder = JSONDecoder()
                    do {
                        let responseData = try decoder.decode(T.self, from: data)
                        success(responseData)
                    } catch {
                        debugPrint(error.localizedDescription)
                        failure(error)
                    }
                    return
                } else {
                    failure(error)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
}
