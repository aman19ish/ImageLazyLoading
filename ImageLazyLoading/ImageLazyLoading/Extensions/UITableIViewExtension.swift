//
//  UITableIViewExtension.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 21/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

extension UITableView {
    private func register<T: UITableViewCell>(cell: T.Type) {
        let nibName = cell.nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    func register<T: UITableViewCell>(with cells: [T.Type]) {

        cells.forEach { cell in
            register(cell: cell)
        }
    }
}
