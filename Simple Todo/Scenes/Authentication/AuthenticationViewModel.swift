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
import Action

struct AuthenticationViewModel {

    fileprivate let sceneCoordinator: SceneCoordinatorType
    fileprivate let userService: UserService
    fileprivate let bag = DisposeBag()

    init(coordinator: SceneCoordinatorType, userService: UserService) {
        self.sceneCoordinator = coordinator
        self.userService = userService
    }

    func onGoogleSignIn() -> CocoaAction {
        return CocoaAction { _ in
            return Observable.just("")
                .do(onNext: { _ in
                    GIDSignIn.sharedInstance().signIn()
                })
                .flatMap { (_) in
                    return GIDSignIn.sharedInstance().rx.userDidSignIn
                }
                .flatMapLatest { (result) -> Observable<SignInResult> in
                    switch result {
                    case .success(let user):
                        return self.userService.logIn(with: .google(token: user.authentication.idToken))
                    case .failure(let error):
                        return Observable.just(.failure(.invalid(msg: error.localizedDescription)))
                    }
                }
                .observeOn(MainScheduler.instance)
                .flatMap { (result: SignInResult) -> Observable<Void> in
                    switch result {
                    case .success(let user):
                        let taskService = try TaskService(syncConfig: SyncConfiguration(user: user, realmURL: RealmConstants.syncServerURL))
                        let taskListViewModel = TaskListsViewModel(taskService: taskService)
                        return self.sceneCoordinator.transition(to: Scene.taskList(taskListViewModel), type: .root)
                    case .failure:
                        return Observable<Void>.just(())
                    }
                }

        }
    }
}
