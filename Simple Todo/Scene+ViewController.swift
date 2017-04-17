//
//  Scene+ViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .authentication:
            let navigationVC = R.storyboard.authentication().instantiateInitialViewController() as! UINavigationController  // swiftlint:disable:this force_cast
            return navigationVC
        }
    }
}
