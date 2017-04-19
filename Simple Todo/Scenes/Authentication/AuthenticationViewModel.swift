//
//  AuthenticationViewModel.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import Action
import RealmSwift

struct AuthenticationViewModel {

    fileprivate let sceneCoordinator: SceneCoordinatorType
    fileprivate let userService: UserService
    fileprivate let bag = DisposeBag()

    let googleLoginTrigger = PublishSubject<String>()

    let loginResult: Observable<SignInResult>

    init(coordinator: SceneCoordinatorType, userService: UserService) {
        self.sceneCoordinator = coordinator
        self.userService = userService

        loginResult = googleLoginTrigger.flatMapLatest { (token) in
            return userService.logIn(with: SyncCredentials.google(token: token))
        }
        .asObservable()
    }

    func onGoogleLoginTap() -> CocoaAction {
        return CocoaAction {
            Observable.create { (observer) -> Disposable in
                GIDSignIn.sharedInstance().signIn()
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }

}
