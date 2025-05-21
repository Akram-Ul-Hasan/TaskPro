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
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
            } else {
                OnboardingScreen()
            }
        }
    }
}
