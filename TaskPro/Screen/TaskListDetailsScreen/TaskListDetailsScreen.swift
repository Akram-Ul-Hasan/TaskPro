//
//  TaskListDetailsScreen.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 22/5/25.
//

import SwiftUI

enum Sheets: Identifiable {
    case sort
    case addTask
    case settings
    case filter

    var id: Int {
        hashValue
    }
}

struct TaskListDetailsScreen: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var activeSheet: Sheets?
    
    @State private var selectedTask: TaskModel?
    @State private var isTaskSelected = false


    let list: TaskListModel
    
    private func deleteList(indexSet: IndexSet) {
        indexSet.forEach { index in
            let task = list.tasks[index]
            context.delete(task)
            
            do {
                try context.save()
                print("Task deleted successfully")
            } catch {
                print("Error from deleting task: \(error.localizedDescription)")
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            if list.tasks.isEmpty {
                Text("No Task here")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                List {
                    ForEach(list.tasks) { task in
                        TaskCellView(task: task)
                            .onTapGesture {
                                selectedTask = task
                                isTaskSelected = true
                            }
                        
                    }
                    .onDelete(perform: deleteList)
                    .navigationDestination(isPresented: $isTaskSelected) {
                        if selectedTask != nil {
                            TaskDetailsScreen()
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        activeSheet = .addTask
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.bottom, 60)
                    .padding(.trailing, 50)
                }
            }
            
        }
        .navigationTitle(list.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(90))

                }
            }
        }
        .sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
            case .addTask:
                AddTaskListView()
          
            default:
                EmptyView()
            }
        })
    }
}

#Preview {
    NavigationStack {
        TaskListDetailsScreen(list: TaskListModel(title: "Akram"))
            .modelContainer(for: [TaskListModel.self, TaskModel.self])
    }
}
