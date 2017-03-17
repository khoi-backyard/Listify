//
//  TaskList.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RealmSwift

class TaskList: Object {
    dynamic var id = NSUUID().uuidString // swiftlint:disable:this variable_name
    dynamic var text = ""
    let items = List<Task>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
