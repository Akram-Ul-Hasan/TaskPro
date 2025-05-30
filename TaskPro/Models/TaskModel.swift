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
    var taskDate: Date
    var priority: TaskPriorityType
    var createdAt: Date
    var isStarred: Bool
    var themeColorHex: String?
    var isSynced: Bool
    var isCompleted: Bool
    
    @Relationship
    var list: TaskListModel?
    
    init(name: String, detail: String? = nil, taskDate: Date, priority: TaskPriorityType, list: TaskListModel? = nil, isStarred: Bool = false, themeColor: String? = "FFFFFF", isSynced: Bool = false, isCompleted: Bool = false) {
        self.id = UUID()
        self.name = name
        self.detail = detail
        self.taskDate = taskDate
        self.priority = priority
        self.createdAt = Date()
        self.list = list
        self.isStarred = isStarred
        self.themeColorHex = themeColor
        self.isSynced = isSynced
        self.isCompleted = isCompleted
    }
}
