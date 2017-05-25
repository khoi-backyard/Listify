//
//  GIDSignIn+Rx.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/19/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Result

public typealias GIDSignInResult = Result<GIDGoogleUser, NSError>

class RxGIDSignInDelegateProxy: DelegateProxy, DelegateProxyType, GIDSignInDelegate {

    fileprivate let _userDidSignIn = PublishSubject<GIDSignInResult>()

    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        guard let gidSignin = object as? GIDSignIn else {
            fatalError()
        }
        return gidSignin.delegate
    }

    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        guard let gidSignin = object as? GIDSignIn else {
            fatalError()
        }
        if delegate == nil {
            gidSignin.delegate = nil
        } else {
            guard let delegate = delegate as? GIDSignInDelegate else {
                fatalError()
            }
            gidSignin.delegate = delegate
        }
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let user = user {
            _userDidSignIn.onNext(GIDSignInResult.success(user))
        } else if let error = error {
            _userDidSignIn.onNext(GIDSignInResult.failure(error as NSError))
        }
        self._forwardToDelegate?.sign(signIn, didSignInFor: user, withError: error)

    }

    deinit {
        _userDidSignIn.onCompleted()
    }
}

public extension Reactive where Base: GIDSignIn {
    public var userDidSignIn: Observable<GIDSignInResult> {
        let proxy = RxGIDSignInDelegateProxy.proxyForObject(base)
        return proxy._userDidSignIn.asObservable()
    }
}
