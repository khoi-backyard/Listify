//
//  NibLoadableView.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/29/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
