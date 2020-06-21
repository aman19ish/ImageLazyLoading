//
//  APIHeader.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

public enum APIHeader: String {
    case contenttype = "Content-Type"
    case applicationjson = "application/json"
    case applicationxml = "application/xml"
    case multipartformdata = "multipart/form-data"
    case authorization = "authorization"
    case basic = "Basic"
    case applicationformurlencoded = "application/x-www-form-urlencoded"
    case authsecret = "accelerator-client:secret"
}
