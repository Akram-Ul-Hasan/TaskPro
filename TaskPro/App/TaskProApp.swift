//
//  TaskProApp.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 20/5/25.
//

import SwiftUI

@main
struct TaskProApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @AppStorage("signIn") private var signIn = false
    
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var auth = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            if !hasSeenOnboarding {
                OnboardingScreen()
            } else if !signIn {
                SignInScreen()
            } else {
                RootTabView(coordinator: coordinator)
            }
        }
        .modelContainer(for: [TaskListModel.self, TaskModel.self])
    }
}
