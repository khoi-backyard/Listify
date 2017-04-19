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
import NSObject_Rx

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        //Configure some dependencies
        let console = ConsoleDestination()
        log.addDestination(console)

        Fabric.with([Crashlytics.self])

        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")

        //Setup View hierarchy
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let sceneCoordinator = SceneCoordinator(window: window!)
        let userService = UserService()

        let authenticationViewModel = AuthenticationViewModel(coordinator: sceneCoordinator, userService: userService)
        let authenticationScene = Scene.authentication(authenticationViewModel)

        sceneCoordinator.transition(to: authenticationScene, type: .root)

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[.sourceApplication] as? String,
                                                 annotation: options[.annotation])
    }
}
