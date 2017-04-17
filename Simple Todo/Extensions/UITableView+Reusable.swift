//
//  UITableView+Reusable.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/29/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit

extension UITableViewCell : Reusable {}

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) where T: Reusable {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func register<T: UITableViewCell>(_ cellClass: T.Type) where T: Reusable, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellClass: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(cellClass.reuseIdentifier)")
        }
        return cell
    }
}
