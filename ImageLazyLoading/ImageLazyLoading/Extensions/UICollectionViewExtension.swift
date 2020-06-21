//
//  UICollectionViewExtension.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    private func register<T: UICollectionReusableView>(cell: T.Type) {
        let nibName = cell.nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cell.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(with cells: [T.Type]) {
        
        debugPrint("cells \(cells)")
        cells.forEach { cell in
            register(cell: cell)
        }
    }

}
