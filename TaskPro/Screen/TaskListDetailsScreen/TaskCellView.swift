//
//  TaskCellView.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 22/5/25.
//

import SwiftUI

struct TaskCellView: View {
    
    @State private var isCompleted: Bool = true
    @State private var isStarred: Bool = false
    let task: TaskModel
    
    var body: some View {
        HStack(spacing: 10) {
            
            Image(systemName: !isCompleted ? "circle" : "checkmark.circle")
                .font(.title2)
                .foregroundColor(isCompleted ? .green : .gray)
                .fontWeight(.semibold)
                .onTapGesture {
                    isCompleted.toggle()
                }
            
            Text(task.name)
                .strikethrough(isCompleted, color: .gray)
                .foregroundColor(isCompleted ? .gray : .primary)
            Spacer()
            Image(systemName: !isStarred ? "star" : "star.fill")
                .font(.title2)
                .foregroundColor(.orange)
                .fontWeight(.semibold)
                .onTapGesture {
                    isStarred.toggle()
                }
        }
    }
}

//#Preview {
//    let task = TaskModel(name: "Meeting", priority: .medium, taskDate: <#Date#>)
//    TaskCellView(task: task)
//        .modelContainer(for: [TaskListModel.self, TaskModel.self])
//}
