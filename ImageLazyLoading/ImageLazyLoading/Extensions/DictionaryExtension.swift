//
//  DictionaryExtension.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

extension Dictionary {
    
    // This function reponsible to merge one dictionnary to other
    mutating func merge(dictionary: [Key: Value]) {
        for (key, value) in dictionary {
            updateValue(value, forKey: key)
        }
    }
}
