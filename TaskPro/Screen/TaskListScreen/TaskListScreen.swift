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
    
    @ObservedObject private var user = AuthManager.shared
    
    @Query(sort: \TaskListModel.createdAt, order: .reverse) private var allList: [TaskListModel]
    @Query private var allTask: [TaskModel]
    @State private var activeSheet: TaskListSheets?
    //    @State private var selectedList: TaskListModel
    
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
                //background color
                Color("WhiteLevel1")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        //Greeting
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text("Hello \(user.currentUser?.name ?? "User")")
                                .font(.largeTitle).bold()
                            
                            Text("Have a nice day")
                                .font(.subheadline.bold())
                                .foregroundColor(.secondary)
                        }.padding(.leading, 20)
                        
                        //task list scrollview
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                VStack {
                                    Image(systemName: "plus")
                                    Text("Add New Task Group")
                                }
                                .frame(width: 250, height: 200)
                                .background(Gradient(colors: [.purple, .blue]))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.leading, 20)
                                .onTapGesture {
                                    activeSheet = .addTaskList
                                }
                                
                                ForEach(allList) { list in
                                    NavigationLink(value: list) {
                                        TaskListCellView(list: list)
                                    }
                                    
                                }
                                .onDelete(perform: deleteList)
                            }
                        }
                        .padding(.bottom, 60)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("Tasks")
                            .font(.title)
                            .foregroundStyle(.primary)
                            .fontWeight(.bold)
                            .padding(.bottom, 25)
                            .padding(.horizontal, 20)
                        
                        ForEach(0..<2/*allTask.count*/) { _ in
                            HStack {
                                // Icon
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.purple)
                                    //                                            .foregroundStyle(Gradient(colors: [.purple, .blue]))
                                        .frame(width: 44, height: 44)
                                    
                                    Image(systemName: "calendar")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20, weight: .medium))
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Design Changes")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text("2 Days ago")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                // Ellipsis Icon
                                Image(systemName: "ellipsis")
                                    .rotationEffect(.degrees(90)) // make it vertical
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        HStack {
                            
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .font(.title2)
                                .foregroundColor(.primary)
                                .padding(.trailing, 10)
                        }
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


