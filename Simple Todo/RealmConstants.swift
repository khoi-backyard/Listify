//
//  RealmConstants.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/22/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import Foundation

struct RealmConstants {
    static let syncHost = "linode1.khoi.io"
    static let syncRealmPath = "tasks"
    static let syncServerURL = URL(string: "realm://\(syncHost):9080/~/\(syncRealmPath)")!
    static let syncAuthURL = URL(string: "http://\(syncHost):9080")!

    static let defaultListName = "My Tasks"
    static let defaultListID = "924C3982-A28A-426C-B9CF-013626903872"
}
