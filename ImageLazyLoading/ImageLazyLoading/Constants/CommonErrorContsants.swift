//
//  CommonErrorContsants.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

extension UIViewController {
    //Storyboard Identifier
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    //Get ViewController Instance
    class func instanceFromStoryboard<T: UIViewController>(storyBoardName: String = Storyboard.imageListView.rawValue, type: T.Type) -> T {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: self.storyboardIdentifier) as! T
        return controller
    }
    
}
