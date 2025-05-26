//
//  OnboardingAnimationPage.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 25/5/25.
//


enum OnboardingAnimationPageType: Int, CaseIterable {
    case first, second, third

    var title: String {
        switch self {
        case .first: return "Welcome to TaskPro"
        case .second: return "Organize Smartly"
        case .third: return "Stay Notified"
        }
    }

    var description: String {
        switch self {
        case .first:
            return "Keep track of important things you need to get done in one place."
        case .second:
            return "Group your tasks into custom lists. Add, edit, and manage your workflow with ease and clarity."
        case .third:
            return "TaskPro can remind you about important deadlines and events. You’ll never miss what matters."
        }
    }
}
