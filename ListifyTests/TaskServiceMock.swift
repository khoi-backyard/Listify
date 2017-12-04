//
//  TaskServiceMock.swift
//  ListifyTests
//
//  Created by Khoi Lai on 12/4/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import Result
import RealmSwift

@testable import Listify

final class TaskServiceMock: TaskServiceType {
    private let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "memory"))
    
    func create(task: Task, in list: TaskList) -> Observable<Task> {
        try! realm.write {
            list.items.append(task)
        }
        return .just(task)
    }
    
    func tasks(in list: TaskList) -> Observable<Results<Task>> {
        let tasks = list.items.sorted(byKeyPath: "dueDate", ascending: true)
        return Observable.collection(from: tasks)
    }
    
    func toggle(task: Task) -> Observable<Task> {
        try! realm.write {
            if task.completedDate == nil {
                task.completedDate = Date()
            } else {
                task.completedDate = nil
            }
        }
        return Observable.just(task)
    }
    
    func taskLists() -> Observable<Results<TaskList>> {
        let taskLists = realm.objects(TaskList.self)
        
        if taskLists.isEmpty {
            createTaskList(list: TaskList(value: [
                "id": RealmConstants.defaultListID,
                "name": RealmConstants.defaultListName
                ]))
        }
        
        return Observable.collection(from: taskLists)
    }
    
    @discardableResult
    func createTaskList(list: TaskList) -> Observable<TaskList> {
        try! realm.write {
            realm.add(list)
        }
        
        return Observable.just(list)
    }
}
