//
//  TaskService.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/24/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

struct TaskService: TaskServiceType {
    private let config: Realm.Configuration

    init(syncConfig: SyncConfiguration) {
        config = Realm.Configuration(syncConfiguration: syncConfig)
    }

    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm(configuration: config)
            return try action(realm)
        } catch let err {
            log.error("Failed \(operation) realm with error: \(err)")
            return nil
        }
    }

    func create(task: Task) -> Observable<Task> {
        let result = withRealm("Creating Task") { (realm) -> Observable<Task> in
            try realm.write {
                realm.add(task)
            }
            return .just(task)
        }

        return result ?? .error(TaskServiceError.creationFailed)
    }

    func tasks() -> Observable<Results<Task>> {
        let result = withRealm("Getting Tasks") { (realm) -> Observable<Results<Task>> in
            let tasks = realm.objects(Task.self)
            return Observable.collection(from: tasks)
        }
        return result ?? .empty()
    }
}
