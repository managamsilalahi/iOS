//
//  Task.swift
//  RealmTasksTutorial
//
//  Created by Managam Silalahi on 1/7/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation
import RealmSwift

final class Task: Object {
    dynamic var text = ""
    dynamic var completed = false
}
