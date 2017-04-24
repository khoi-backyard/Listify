//
//  Scene+ViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

// swiftlint:disable force_cast

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .authentication(let viewModel):
            let navigationVC = R.storyboard.authentication().instantiateInitialViewController() as! UINavigationController
            var authenticationVC = navigationVC.viewControllers.first as? AuthenticationViewController
            authenticationVC?.bindViewModel(to: viewModel)
            return navigationVC
        case .task(let viewModel):
            let navigationVC = R.storyboard.task().instantiateInitialViewController() as! UINavigationController
            var taskVC = navigationVC.viewControllers.first as? TasksViewController
            taskVC?.bindViewModel(to: viewModel)
            return navigationVC
        }

    }
}
