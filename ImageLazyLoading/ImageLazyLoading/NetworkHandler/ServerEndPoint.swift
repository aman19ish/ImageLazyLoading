//
//  ServerEndPoint.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

open class ServerEndPoint {
    
    private static var serverURLDictionary = [String: String]()
    static public var baseUrlString: String = ""
    
    static public func getAPIEndPoint(for key: String) -> String {
        
        let serverPath = serverURLDictionary[key] ?? ""
        return serverPath
    }
}
