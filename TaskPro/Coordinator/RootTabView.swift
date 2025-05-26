//
//  RootTabView.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//
import SwiftUI

enum AppTab: Hashable {
    case tasks
    case calendar
    case starred
    case settings
}

struct RootTabView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            TaskListView()
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.circle")
                }
                .tag(AppTab.tasks)
            
            CalenderTabView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(AppTab.calendar)
            
            StarredView()
                .tabItem {
                    Label("Starred", systemImage: "star.fill")
                }
                .tag(AppTab.starred)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(AppTab.settings)
        }
    }
}
