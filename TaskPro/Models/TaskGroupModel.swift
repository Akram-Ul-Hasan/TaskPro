//
//  TaskGroupModel.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//

import Foundation
import SwiftData

@Model
final class TaskListModel: Identifiable {
    var id: UUID
    var title: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade)
    var tasks: [TaskModel]
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = Date()
        self.tasks = []
    }
}
