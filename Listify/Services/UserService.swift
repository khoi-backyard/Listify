//
//  UserService.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/19/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Result
import GoogleSignIn


enum LoginError: Error {
    case invalid(msg: String?)
}

typealias SignInResult = Result<SyncUser, LoginError>

protocol UserServiceType {
    func logIn(with syncCredentials: SyncCredentials, server: URL) -> Observable<SignInResult>
    func logOut()
}

struct UserService: UserServiceType {
    func logIn(with syncCredentials: SyncCredentials, server: URL = RealmConstants.syncAuthURL) -> Observable<SignInResult> {
        return Observable.create { (observer) -> Disposable in
            SyncUser.logIn(with: syncCredentials, server: server, onCompletion: { (user, error) in
                if let error = error {
                    observer.onNext(SignInResult.failure(LoginError.invalid(msg: error.localizedDescription)))
                }
                if let user = user {
                    observer.onNext(SignInResult.success(user))
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }

    func logOut() {
        GIDSignIn.sharedInstance().signOut()
        SyncUser.all.values.forEach {
            $0.logOut()
        }
    }
}
