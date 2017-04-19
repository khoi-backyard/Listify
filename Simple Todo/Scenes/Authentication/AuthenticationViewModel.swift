//
//  AuthenticationViewModel.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

struct AuthenticationViewModel {

    fileprivate let sceneCoordinator: SceneCoordinatorType
    fileprivate let userService: UserService
    fileprivate let bag = DisposeBag()

    let googleLoginTap = PublishSubject<Void>()

    let loginResult: Driver<SignInResult>

    init(coordinator: SceneCoordinatorType, userService: UserService) {

        self.sceneCoordinator = coordinator
        self.userService = userService

        loginResult =
            googleLoginTap.do(onNext: { (_) in
            GIDSignIn.sharedInstance().signIn()
        })
        .flatMapLatest { (_) in
            return GIDSignIn.sharedInstance().rx.userDidSignIn
        }
        .flatMap { (result) -> Observable<SignInResult> in
            switch result {
            case .success(let user):
                return userService.logIn(with: .google(token: user.authentication.idToken))
            case .failure(let error):
                return Observable.just(.failure(.invalid(msg: error.localizedDescription)))
            }
        }
        .asDriver(onErrorJustReturn: SignInResult.failure(.invalid(msg: "Something went wrong!")))

    }

}
