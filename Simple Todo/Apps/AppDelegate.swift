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

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let console = ConsoleDestination()
        log.addDestination(console)

        Fabric.with([Crashlytics.self])

        let sceneCoordinator = SceneCoordinator(window: window!)

        let authenticationViewModel = AuthenticationViewModel()
        let authenticationScene = Scene.authentication(authenticationViewModel)

        sceneCoordinator.transition(to: authenticationScene, type: .root)

        return true
    }
}
