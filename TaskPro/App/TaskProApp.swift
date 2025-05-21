//
//  TaskProApp.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 20/5/25.
//

import SwiftUI

@main
struct TaskProApp: App {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                RootTabView(coordinator: coordinator)
            } else {
                OnboardingScreen()
            }
        }
    }
}
