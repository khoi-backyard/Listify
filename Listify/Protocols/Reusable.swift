//
//  Reusable.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/29/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
