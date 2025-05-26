//
//  TaskSyncManager.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 26/5/25.
//

import Firebase
import SwiftData
import FirebaseDatabaseInternal

class TaskSyncManager {
    static let shared = TaskSyncManager()
    private init() {}
    
    func syncPendingTasks() {
        do {
            let container = try ModelContainer(for: TaskModel.self)
            let context = ModelContext(container)
            
            let descriptor = FetchDescriptor<TaskModel>(predicate: #Predicate { !$0.isSynced })
            let pendingTasks = try context.fetch(descriptor)
            
            for task in pendingTasks {
                syncToFirebase(task: task) { success in
                    if success {
                        task.isSynced = true
                        try? context.save()
                    }
                }
            }
        } catch {
            print("Error setting up context or fetching unsynced tasks: \(error)")
        }
    }
    
    func syncToFirebase(task: TaskModel, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference()
        ref.child("tasks").child(task.id.uuidString).setValue([
            "title": task.name,
            "isCompleted": task.isCompleted
        ]) { error, _ in
            completion(error == nil)
        }
    }
    
    func fetchAndStoreRemoteTasks(for userID: String) {
//        do {
//            let container = try ModelContainer(for: TaskModel.self)
//            let context = ModelContext(container)
//            let ref = Database.database().reference().child("users/\(userID)/tasks")
//            
//            ref.observeSingleEvent(of: .value) { snapshot in
//                guard let data = snapshot.value as? [String: [String: Any]] else { return }
//                
//                for (id, taskDict) in data {
//                    if let title = taskDict["title"] as? String,
//                       let isCompleted = taskDict["isCompleted"] as? Bool {
//                        let task = Task(id: id, title: title, isCompleted: isCompleted, isSynced: true)
//                        context.insert(task)
//                    }
//                }
//                
//                try context.save()
//            }
//        } catch {
//            print(error)
//        }
    }
    
}
