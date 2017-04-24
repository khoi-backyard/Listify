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

    init(taskService: TaskServiceType) {
        self.taskService = taskService
    }

    var sectionedItems: Observable<[TaskSection]> {
        return taskService.tasks().map { results in
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
            self.taskService.toggle(task: task).map { _ in }
        }
    }
}
