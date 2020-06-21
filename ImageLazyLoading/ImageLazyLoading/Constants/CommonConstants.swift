//
//  CommonConstants.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

// MARK: - Common Singleton Objects
let kUserDefault = UserDefaults.standard
let kAppDelegate = UIApplication.shared.delegate as? AppDelegate
let kSuccessfullSearchMaxResult = 10

enum UserDefaultKeys: String {
    case kSearchAutoSuggestion
}
