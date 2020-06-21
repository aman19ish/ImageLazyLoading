//
//  ImageLazyLoadingUtilityMethods.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class ImageLazyLoadingUtilityMethods {
    class func getKeyboardHeightBy(notification: NSNotification) -> CGFloat? {
        if let userInfo =  notification.userInfo {
            if let size = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject? {
                return size.cgRectValue.size.height
            }
        }
        return nil
    }
    
}
