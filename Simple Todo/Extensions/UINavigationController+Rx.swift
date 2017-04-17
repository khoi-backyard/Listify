//
//  UINavigationController+rx.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxNavigationControllerDelegateProxy: DelegateProxy, UINavigationControllerDelegate, DelegateProxyType {
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        guard let navigationController = object as? UINavigationController else {
            fatalError()
        }
        return navigationController.delegate
    }

    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        guard let navigationController = object as? UINavigationController else {
            fatalError()
        }
        if delegate == nil {
            navigationController.delegate = nil
        } else {
            guard let delegate = delegate as? UINavigationControllerDelegate else {
                fatalError()
            }
            navigationController.delegate = delegate
        }
    }
}

extension Reactive where Base: UINavigationController {
    public var delegate: DelegateProxy { // swiftlint:disable:this weak_delegate
        return RxNavigationControllerDelegateProxy.proxyForObject(base)
    }
}
