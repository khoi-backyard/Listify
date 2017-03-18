//
//  AppDelegate.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17
//  Copyright (c) 2017 khoi.io. All rights reserved.
//

import UIKit
import NSObject_Rx
import SwiftyBeaver
import Fabric
import Crashlytics

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        let console = ConsoleDestination()
        log.addDestination(console)

        Fabric.with([Crashlytics.self])

        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
