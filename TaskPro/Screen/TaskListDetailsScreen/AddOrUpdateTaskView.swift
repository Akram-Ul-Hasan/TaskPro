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
    
    @State private var taskName: String = ""
    @State private var detail: String = ""
    @State private var priority: TaskPriorityType = .medium
    @State private var themeColor: String = ""
    @State private var isStarred: Bool = false
    @State private var taskDate : Date = Date.now
    
    private var isTitleValid: Bool {
        !taskName.isEmptyOrWhiteSpace
    }
    
    private func saveTask() {
        let task = TaskModel(name: taskName, taskDate: taskDate, priority: priority, list: list)
        context.insert(task)
        list.tasks.append(task)
        
        do {
            try context.save()
            print("Save Task successfully")
            taskName = ""
            detail = ""
            dismiss()
        } catch {
            print("Failed to save task: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Image("taskListBg")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 2.2)
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea(edges: .top)
                .overlay(
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Name")
                                .foregroundColor(.white)
                            
                            ZStack(alignment: .leading) {
                                if taskName.isEmpty {
                                    Text("Enter task name")
                                        .foregroundColor(.white.opacity(0.5))
                                        .font(.title)
                                        .padding(.horizontal, 4)
                                }
                                
                                TextField("", text: $taskName)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .font(.title)
                            }
                        }
                        
                        // Date
                        HStack(spacing: 5) {
                            Text("Date")
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            DatePicker("", selection: $taskDate, displayedComponents: .date)
                                .labelsHidden()
                                .accentColor(.white)
                                .background(.white.opacity(0.9))
                                .cornerRadius(10)
                                
                        }
                        Spacer()
                    }.padding(30)
                
                )
                    
            
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(uiColor: .systemBackground))
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: UIScreen.main.bounds.height / 1.4)
                    .edgesIgnoringSafeArea(.bottom)
                    .padding(.horizontal, 0)
                    .overlay(
                        VStack {
                            
                            
                        }
                        .padding()
                    )
            }
            .offset(y: 50)
        }
//                    .frame(maxWidth: .infinity)
                
                
//                VStack(spacing: 20) {
//                    Text("Add New Task List")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .padding(.top, 40)
//                    
//                    VStack(alignment: .leading, spacing: 6) {
//                        Text("Task Name")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                        
//                        TextField("Enter task list name", text: $name)
//                            .padding(12)
//                            .background(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//                            )
//                            .autocapitalization(.words)
//                            .disableAutocorrection(true)
//                            .padding(.bottom, 20)
//                        
//                        Text("Task description (Optional)")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                        TextField("Enter task description", text: $detail)
//                            .padding(12)
//                            .background(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//                            )
//                            .autocapitalization(.words)
//                            .disableAutocorrection(true)
//                            .padding(.bottom, 20)
//                        
//                        Text("Select Priority")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                        Picker("Select Priority", selection: $priority) {
//                            ForEach(TaskPriorityType.allCases, id: \.rawValue) { priority in
//                                Text(priority.rawValue).tag(priority)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                        .padding(.bottom, 20)
//                        
//                        HStack {
//                            Image(systemName: "clock")
//                            
//                            
//                            Image(systemName: "alarm")
//                            
//                            Image(systemName: !isStarred ? "star" : "star.fill")
//                                .foregroundStyle(Color.orange)
//                            
//                        }
//                    }
//                    .padding(.horizontal)
//                    
//                    
//                    DatePicker(
//                        "Select Date & Time",
//                        selection: $taskDate,
//                        displayedComponents: [.date, .hourAndMinute]
//                    )
//                    .datePickerStyle(GraphicalDatePickerStyle())
//                    .environment(\.colorScheme, .light)
//                    Text("Selected: \(taskDate.formatted(date: .abbreviated, time: .shortened))")
//                    //            Spacer()
//                    
//                    PrimaryButton(title: "Save", isDisabled: !isTitleValid) {
//                        saveTask()
//                    }
//                    .padding()
//                    
//                    Spacer(minLength: 40)
//                }
//                .frame(height: 100)
//                .background(Color(UIColor.systemBackground))
////                .edgesIgnoringSafeArea(.bottom)
//                
            }
//            .frame(minWidth: .infinity, maxHeight: .infinity)
        }
    


                    
#Preview {
    let list = TaskListModel(title: "Sample List")
    return AddOrUpdateTaskView(list: list)
        .modelContainer(for: [TaskListModel.self, TaskModel.self], inMemory: true)
}
