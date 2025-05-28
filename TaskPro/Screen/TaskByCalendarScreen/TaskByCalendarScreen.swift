//
//  TaskByCalendarScreen.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 26/5/25.
//

import SwiftUI
import SwiftData

struct TaskByCalendarScreen: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var tasksForSelectedDate: [TaskModel] = []
    
    @State private var selectedSessionDate: Date = Date.now
    //    @State private var selectedSessionHour: Date = Date.now
    
    //    var onDateSelected: (String) -> Void
    
//    private func fetchTasks(for selectedDate: Date) {
//        let selectedDay = Calendar.current.startOfDay(for: selectedDate)
//        
//        let predicate = #Predicate<TaskModel> {
//            Calendar.current.startOfDay(for: $0.taskDate) == selectedDay
//        }
//        
//        let descriptor = FetchDescriptor<TaskModel>(predicate: predicate)
//        
//        do {
//            let results = try context.fetch(descriptor)
//            tasksForSelectedDate = results
//        } catch {
//            print("Failed to fetch tasks: \(error)")
//        }
//    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView {
                    selectedDate in
                    self.selectedSessionDate = selectedDate
                }
                Spacer()
            }
        }
    }
}

#Preview {
    TaskByCalendarScreen()
}
