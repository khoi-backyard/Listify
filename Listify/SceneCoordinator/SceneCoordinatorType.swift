//
//  CoordinatorType.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    init(window: UIWindow, userService: UserService)

    var userService: UserService { get }

    @discardableResult
    func transition(to: Scene, type: SceneTransitionType) -> Observable<Void> // swiftlint:disable:this variable_name

    @discardableResult
    func pop(animated: Bool) -> Observable<Void>

    @discardableResult
    func showAuthentication() -> Observable<Void>
}

extension SceneCoordinatorType {
    func pop() -> Observable<Void> {
        return pop(animated: true)
    }
}
