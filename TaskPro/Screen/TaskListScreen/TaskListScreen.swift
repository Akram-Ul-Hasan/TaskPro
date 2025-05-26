//
//  TaskListScreen.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//

import SwiftUI
import SwiftData

enum TaskListSheets: Identifiable {
    case addTaskList
    case sort
    
    var id: Int {
        hashValue
    }
}
struct TaskListScreen: View {

    @Environment(\.modelContext) private var context
    
    @Query(sort: \TaskListModel.createdAt, order: .reverse) private var allList: [TaskListModel]
    @State private var activeSheet: TaskListSheets?

    private func deleteList(indexSet: IndexSet) {
        indexSet.forEach { index in
            let list = allList[index]
            context.delete(list)
            
            do {
                try context.save()
                print("Task list deleted successfully")
            } catch {
                print("Error from deleting task list: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if allList.isEmpty {
                    Text("No lists here")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    List {
                        ForEach(allList) { list in
                            NavigationLink(value: list) {
                                TaskListCellView(list: list)
                            }
                            
                        }
                        .onDelete(perform: deleteList)
                    }
                    .navigationDestination(for: TaskListModel.self) { list in
                        TaskListDetailsScreen(list: list)
                            .navigationTitle(list.title)
                        
                    }
                    .listStyle(.plain)
                }
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            activeSheet = .addTaskList
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
            .navigationTitle("All Lists")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        activeSheet = .sort
                    }) {
                        HStack {
                            Text("Sort by")
                                .foregroundColor(.primary)

                            
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(
                            Color.gray.opacity(0.01)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 21)
                                .stroke(Color.gray, lineWidth: 1)
                                .foregroundStyle(.gray.opacity(0.2))
                                .background(Color.gray.opacity(0.2))

                        )
                        .cornerRadius(21)

                    }
                }
            }
            .sheet(item: $activeSheet, content: { activeSheet in
                switch activeSheet {
                case .addTaskList:
                    AddTaskListView()
                        .presentationDetents([.fraction(0.45)])
                case .sort:
                    TaskListSortView()
                        .presentationDetents([.fraction(0.3)])
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        TaskListScreen()
            .modelContainer(for: [TaskListModel.self, TaskModel.self])

    }
}


