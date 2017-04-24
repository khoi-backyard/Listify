//
//  Task.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RealmSwift
import RxDataSources

class Task: Object {
    dynamic var id = NSUUID().uuidString // swiftlint:disable:this variable_name
    dynamic var text = ""

    dynamic var added: Date = Date()
    dynamic var completedDate: NSDate?
    dynamic var reminderDate: NSDate?
    dynamic var dueDate: NSDate?

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Task: IdentifiableType {
    var identity: String {
        return id
    }
}
