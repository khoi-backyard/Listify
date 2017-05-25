//
//  TaskList.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RealmSwift
import RxDataSources

class TaskList: Object {
    dynamic var id = NSUUID().uuidString // swiftlint:disable:this variable_name
    dynamic var name = ""

    /// Sort order of a task list, the higher the number the higher the priority
    dynamic var sortOrder = 0

    let items = List<Task>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension TaskList: IdentifiableType {
    var identity: String {
        return self.isInvalidated ? UUID().uuidString : id
    }
}
