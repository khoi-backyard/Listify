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
import RxCocoa

struct CreateTaskViewModel {
    fileprivate let taskService: TaskServiceType
    fileprivate let sceneCoordinator: SceneCoordinatorType
    fileprivate let taskList: TaskList

    init(taskService: TaskServiceType,
         coordinator: SceneCoordinatorType,
         taskList: TaskList) {
        self.taskService = taskService
        self.sceneCoordinator = coordinator
        self.taskList = taskList
    }

    func onDismissed() -> CocoaAction {
        return CocoaAction {
            return self.sceneCoordinator.pop(animated: true)
        }
    }

    lazy var onTaskTitleChanged: Action<String, Bool> = { this in
        return Action<String, Bool> { text in
            return text.isEmpty ? .just(false) : .just (true)
        }
    }(self)

    lazy var onCreateTask: Action<String, Void> = { this in
        return Action<String, Void> { taskText in
            return this.taskService.create(task: Task(value: ["text": taskText]), in: this.taskList)
                .map { _ in
                    this.sceneCoordinator.pop(animated: true)
                }
        }
    }(self)
}
