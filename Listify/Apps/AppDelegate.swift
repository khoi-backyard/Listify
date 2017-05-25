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
import NSObject_Rx
import RealmSwift
import Fabric
import Crashlytics
import Firebase

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        //Configure some dependencies
        Fabric.with([Crashlytics.self])
        FIRApp.configure()

        let console = ConsoleDestination()
        log.addDestination(console)

        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")

        //Setup View hierarchy
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let userService = UserService()
        let sceneCoordinator = SceneCoordinator(window: window!, userService: userService)

        if let user = SyncUser.current,
            let taskService = try? TaskService(syncConfig: SyncConfiguration(user: user,
                                                                             realmURL: RealmConstants.syncServerURL)) {
            let listViewModel = ListsViewModel(taskService: taskService, coordinator: sceneCoordinator)
            sceneCoordinator.transition(to: Scene.taskList(listViewModel), type: .root)
        } else {
            sceneCoordinator.showAuthentication()
        }

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[.sourceApplication] as? String,
                                                 annotation: options[.annotation])
    }
}
