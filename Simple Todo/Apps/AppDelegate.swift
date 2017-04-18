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

        //Configure some dependencies
        let console = ConsoleDestination()
        log.addDestination(console)

        Fabric.with([Crashlytics.self])

        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        GIDSignIn.sharedInstance().delegate = self

        //Setup View hierarchy
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let sceneCoordinator = SceneCoordinator(window: window!)

        let authenticationViewModel = AuthenticationViewModel()
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

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            log.debug("\(user)")
        } else {
            log.error("\(error.localizedDescription)")
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        log.debug("\(user) logged out")
    }
}
