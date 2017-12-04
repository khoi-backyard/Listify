//
//  CoordinatorMock.swift
//  ListifyTests
//
//  Created by Khoi Lai on 12/4/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
@testable import Listify

final class CoordinatorMock: SceneCoordinatorType {
    
    
    var userService: UserService?
    
    init() {
        
    }

    init(window: UIWindow, userService: UserService?) {
        self.userService = userService
    }
    
    func pop(animated: Bool) -> Observable<Void> {
        return Observable<Void>.just(())
    }
    
    func transition(to: Scene, type: SceneTransitionType) -> Observable<Void> {
        return Observable<Void>.just(())
    }
    
    func showAuthentication() -> Observable<Void> {
        return Observable<Void>.just(())
    }
    

}
