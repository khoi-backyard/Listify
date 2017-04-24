//
//  TaskServiceType.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/24/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

enum TaskServiceError: Error {
    case creationFailed
}

protocol TaskServiceType {
    func create(task: Task) -> Observable<Task>
    func tasks() -> Observable<Results<Task>>
}
