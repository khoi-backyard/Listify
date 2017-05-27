//
//  CreateTaskViewModel.swift
//  Listify
//
//  Created by Khoi Lai on 5/27/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

struct CreateTaskViewModel {
    fileprivate let taskService: TaskServiceType
    fileprivate let sceneCoordinator: SceneCoordinatorType

    init(taskService: TaskServiceType, coordinator: SceneCoordinatorType) {
        self.taskService = taskService
        self.sceneCoordinator = coordinator
    }

    func onDismissed() -> CocoaAction {
        return CocoaAction {
            return self.sceneCoordinator.pop(animated: true)
        }
    }
}
