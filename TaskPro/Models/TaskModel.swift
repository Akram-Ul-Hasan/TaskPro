//
//  TaskModel.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//

import Foundation
import SwiftData

@Model
class TaskModel {
    var id: UUID
    var name: String
    var detail: String?
    var dueTime: Date
    var priority: TaskPriorityType
    var createdAt: Date
    var isStarred: Bool
    var themeColorHex: String?
    
    @Relationship
    var group: TaskGroupModel?
    
    init(name: String, detail: String? = nil, dueTime: Date, priority: TaskPriorityType, group: TaskGroupModel? = nil, isStarred: Bool = false, themeColor: String) {
        self.id = UUID()
        self.name = name
        self.detail = detail
        self.dueTime = dueTime
        self.priority = priority
        self.createdAt = Date()
        self.group = group
        self.isStarred = isStarred
        self.themeColorHex = themeColor
    }
}
