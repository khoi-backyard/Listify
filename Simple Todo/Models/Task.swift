//
//  Task.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    dynamic var text = ""
    dynamic var completedDate: NSDate?
    dynamic var reminderDate: NSDate?
    dynamic var dueDate: NSDate?
}
