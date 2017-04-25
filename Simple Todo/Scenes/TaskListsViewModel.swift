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

typealias TaskListsSection = AnimatableSectionModel<String, TaskList>

struct TaskListsViewModel {

    let taskService: TaskServiceType

    init(taskService: TaskServiceType) {
        self.taskService = taskService
    }

    var sectionItems: Observable<[TaskListsSection]> {
        return taskService.taskLists().map({ (results) in
            let lists = results.sorted(byKeyPath: "sortOrder", ascending: false)
            return [
                TaskListsSection(model: "Task Lists", items: lists.toArray())
            ]
        })
    }

}
