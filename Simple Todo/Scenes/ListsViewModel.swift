//
//  TaskListsViewModel.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/25/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

typealias ListsSection = AnimatableSectionModel<String, TaskList>

struct ListsViewModel {

    fileprivate let taskService: TaskServiceType
    fileprivate let sceneCoordinator: SceneCoordinatorType

    init(taskService: TaskServiceType, coordinator: SceneCoordinatorType) {
        self.taskService = taskService
        self.sceneCoordinator = coordinator

    }

    var sectionItems: Observable<[ListsSection]> {
        return taskService.taskLists().map({ (results) in
            let lists = results.sorted(byKeyPath: "sortOrder", ascending: false)
            return [
                ListsSection(model: "Task Lists", items: lists.toArray())
            ]
        })
    }

    lazy var selectListAction: Action<TaskList, Void> = { this in
        return Action { list -> Observable<Void> in
            let taskViewModel = TasksViewModel(taskService: this.taskService, taskList: list, coordinator: this.sceneCoordinator)
            return this.sceneCoordinator.transition(to: Scene.tasks(taskViewModel), type: .push)
        }
    }(self)
}
