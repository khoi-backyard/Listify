//
//  Then.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation

protocol Then {
}

extension Then where Self: AnyObject {
    func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }

}
extension NSObject: Then {}
