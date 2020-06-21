//
//  ResponseStatusCode.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

enum ResponseStatusCode: Int {
    case successMinRange = 200
    case successMaxRange = 299
    case badrequest = 400
    case nointernet = 503
}
