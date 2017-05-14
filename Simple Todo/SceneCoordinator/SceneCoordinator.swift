//
//  SceneCoordinator.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {

    private var window: UIWindow
    private var currentViewController: UIViewController?
    var userService: UserService

    required init(window: UIWindow, userService: UserService) {
        self.window = window
        currentViewController = window.rootViewController
        self.userService = userService
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }

    @discardableResult
    func showAuthentication() -> Observable<Void> {
        let authenticationViewModel = AuthenticationViewModel(coordinator: self, userService: userService)
        let authenticationScene = Scene.authentication(authenticationViewModel)
        return transition(to: authenticationScene, type: .root)
    }

    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        let viewController = scene.viewController()
        switch type {
        case .root:
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
            subject.onCompleted()
        case .push:
            guard let navigationController = currentViewController?.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bindTo(subject)
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        case .modal:
            currentViewController?.present(viewController, animated: true) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        }
        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }

    @discardableResult
    func pop(animated: Bool) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        if let presenter = currentViewController?.presentingViewController {
            // dismiss a modal controller
            currentViewController?.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
                subject.onCompleted()
            }
        } else if let navigationController = currentViewController?.navigationController {
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bindTo(subject)
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(String(describing: currentViewController))")
            }
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(String(describing: currentViewController))")
        }
        return subject.asObservable().take(1).ignoreElements()
    }

}
