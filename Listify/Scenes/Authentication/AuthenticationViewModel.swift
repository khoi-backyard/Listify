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
    
    func onOfflineUsage() -> CocoaAction {
        return CocoaAction { _ in
            guard let taskService = try? TaskService(config: .defaultConfiguration) else {
                return Observable<Void>.just(())
            }
            let taskListViewModel = ListsViewModel(taskService: taskService, coordinator: self.sceneCoordinator)
            return self.sceneCoordinator.transition(to: Scene.taskList(taskListViewModel), type: .root)
        }
    }

    func onGoogleSignIn() -> CocoaAction {
        return CocoaAction { _ in
            return Observable.just("")
                .do(onNext: { _ in
                    self.userService.logOut()
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
                        let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: RealmConstants.syncServerURL))
                        let taskService = try TaskService(config: config)
                        let taskListViewModel = ListsViewModel(taskService: taskService, coordinator: self.sceneCoordinator)
                        return self.sceneCoordinator.transition(to: Scene.taskList(taskListViewModel), type: .root)
                    case .failure:
                        return Observable<Void>.just(())
                    }
                }
                .take(1)
            
        }
    }
}
