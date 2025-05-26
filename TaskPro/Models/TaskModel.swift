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
    var notifyTime: Date?
    var priority: TaskPriorityType
    var createdAt: Date
    var isStarred: Bool
    var themeColorHex: String?
    
    @Relationship
    var list: TaskListModel?
    
    init(name: String, detail: String? = nil, notifyTime: Date? = nil, priority: TaskPriorityType, list: TaskListModel? = nil, isStarred: Bool = false, themeColor: String? = "FFFFFF") {
        self.id = UUID()
        self.name = name
        self.detail = detail
        self.notifyTime = notifyTime
        self.priority = priority
        self.createdAt = Date()
        self.list = list
        self.isStarred = isStarred
        self.themeColorHex = themeColor
    }
}
