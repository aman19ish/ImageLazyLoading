//
//  ServiceProtocol.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public protocol ServiceProtocol {
    var baseURLString: String { get }
    var key: String { get }
    var path: String { get }
    var subPath: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: HTTPHeaders? { get }
    var parametersEncoding: ParametersEncoding { get }
    var shouldAppendBaseURL: Bool { get }
    var shouldAppendSubPath: Bool { get }
    var privateHeaders: [String: String] { get }
    var completeUrlString: String { get }
}

public extension ServiceProtocol {
    
    var baseURLString: String {
        return ServerEndPoint.baseUrlString
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        return .requestPlain("")
    }
    
    var headers: HTTPHeaders? {
        var headerParam = [String: String]()
        headerParam[APIHeader.contenttype.rawValue] = APIHeader.applicationjson.rawValue
        headerParam.merge(dictionary: privateHeaders)
        return headerParam
    }
    
    var parametersEncoding: ParametersEncoding {
        return method == .post ? .json : .url
    }
    
    var shouldAppendBaseURL: Bool {
        return true
    }
    
    var shouldAppendSubPath: Bool {
        return false
    }
    
    var privateHeaders: [String: String] {
        return [:]
    }
    
    var path: String {
        return ServerEndPoint.getAPIEndPoint(for: key)
    }
    
    var subPath: String {
        return ""
    }
    
    var completeUrlString: String {
        
        var urlString = ""
        if shouldAppendBaseURL {
            urlString = "\(baseURLString)\(path)"
        } else {
            urlString = path
        }
        if shouldAppendSubPath, subPath.count > 0 {
            urlString = "\(urlString)/\(subPath)"
        }
        return urlString
    }
}
