//
//  TasksViewModel.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/24/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

typealias TaskSection = AnimatableSectionModel<String, Task>

struct TasksViewModel {

    let taskService: TaskServiceType
    let taskList: TaskList
    fileprivate let sceneCoordinator: SceneCoordinatorType

    init(taskService: TaskServiceType, taskList: TaskList, coordinator: SceneCoordinatorType) {
        self.taskService = taskService
        self.taskList = taskList
        self.sceneCoordinator = coordinator
        SoundService.shared.prepareSound(fileName: R.file.successWav.fullName)
    }

    var sectionedItems: Observable<[TaskSection]> {
        return taskService.tasks(in: taskList).map { results in
            let completedTasks = results
                .filter("completedDate != nil")
                .sorted(byKeyPath: "added", ascending: false)

            let dueTasks = results
                .filter("completedDate == nil")
                .sorted(byKeyPath: "completedDate", ascending: false)
            return [
                TaskSection(model: "Due Tasks", items: dueTasks.toArray()),
                TaskSection(model: "Completed", items: completedTasks.toArray())
            ]
        }
    }

    func onToggle(task: Task) -> CocoaAction {
        return CocoaAction { _ in
            self.taskService.toggle(task: task)
                .do(onNext: { (task) in
                    if task.completedDate != nil {
                        SoundService.shared.playSound(fileName: R.file.successWav.fullName)
                    }
                })
                .map { _ in }
        }
    }

    func onCreate() -> CocoaAction {
        return CocoaAction {
            let createTaskViewModel = CreateTaskViewModel(taskService: self.taskService, coordinator: self.sceneCoordinator)
            return self.sceneCoordinator.transition(to: Scene.createTask(createTaskViewModel), type: .modal)
        }
    }

    func onPop() -> CocoaAction {
        return CocoaAction {
            self.sceneCoordinator.pop()
        }
    }
 }
