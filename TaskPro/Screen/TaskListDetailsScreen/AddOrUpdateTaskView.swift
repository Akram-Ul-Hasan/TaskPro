////
////  AddOrUpdateTaskView.swift
////  TaskPro
////
////  Created by Akram Ul Hasan on 22/5/25.
////

import SwiftUI

struct AddOrUpdateTaskView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var list: TaskListModel
    
    @State private var name: String = ""
    @State private var detail: String = ""
    @State private var priority: TaskPriorityType = .medium
    @State private var themeColor: String = ""
    @State private var isStarred: Bool = false
    @State private var dueTime : Date? = nil
    
    private var isTitleValid: Bool {
        !name.isEmptyOrWhiteSpace
    }
    
    private func saveTask() {
        let task = TaskModel(name: name, priority: priority, list: list)
        context.insert(task)
        list.tasks.append(task)
        
        do {
            try context.save()
            print("Save Task successfully")
            name = ""
            detail = ""
            dismiss()
        } catch {
            print("Failed to save task: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Task List")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Task Name")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("Enter task list name", text: $name)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)

                Text("Task description (Optional)")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter task description", text: $detail)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)
                
                Text("Select Priority")
                    .font(.caption)
                    .foregroundColor(.gray)
                Picker("Select Priority", selection: $priority) {
                    ForEach(TaskPriorityType.allCases, id: \.rawValue) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: "clock")
                    
                    
                    Image(systemName: "alarm")
                    
                    Image(systemName: !isStarred ? "star" : "star.fill")
                        .foregroundStyle(Color.orange)
                    
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            PrimaryButton(title: "Save", isDisabled: !isTitleValid) {
                saveTask()
            }
            .padding()
            
            Spacer(minLength: 40)
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    let list = TaskListModel(title: "Sample List")
    return AddOrUpdateTaskView(list: list)
        .modelContainer(for: [TaskListModel.self, TaskModel.self], inMemory: true)
}
