//
//  Task.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public enum Task {
    case requestPlain(String)
    case requestParameters(Parameters)
}
