//
//  TaskList.swift
//  RealmTasksTutorial
//
//  Created by Managam Silalahi on 1/7/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation
import RealmSwift

final class TaskList: Object {
    dynamic var text = ""
    dynamic var id = ""
    let items = List<Task>()
    
    override static func primaryKey() -> String {
        return "id"
    }
}
