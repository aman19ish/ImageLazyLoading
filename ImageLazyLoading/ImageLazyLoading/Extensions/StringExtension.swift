//
//  StringExtension.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

extension String {
    public func urlEncoded() -> String {
        let string = self
        
        var characterSet = NSMutableCharacterSet.urlQueryAllowed
        
        let delimitersToEncode = ":#[]@!$?&'()*+= "
        characterSet.remove(charactersIn: delimitersToEncode)
        
        return string.addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet) ?? string
    }
    
}
