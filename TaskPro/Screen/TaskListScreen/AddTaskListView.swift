//
//  AddTaskListView.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//

import SwiftUI

struct AddTaskListView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    
    private var isTitleValid: Bool {
        !title.isEmptyOrWhiteSpace
    }
    private func saveNewTaskList() {
        let newTaskList = TaskListModel(title: title)
        context.insert(newTaskList)
        
        do {
            try context.save()
            print("Save new Task List successfully")
            title = ""
            dismiss()
        } catch {
            print("Failed to save task group: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Task List")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Task List Name")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("Enter task list name", text: $title)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)
            
            Spacer()
            
            PrimaryButton(title: "Save", isDisabled: !isTitleValid) {
                saveNewTaskList()
            }
            .padding()
            
            Spacer(minLength: 40)
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    AddTaskListView()
        .modelContainer(for: [TaskListModel.self, TaskModel.self])
}
