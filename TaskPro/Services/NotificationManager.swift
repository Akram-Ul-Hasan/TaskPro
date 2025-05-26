//
//  NotificationManager.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 26/5/25.
//

import Foundation
import UserNotifications

struct NotificationManager {
    static func scheduleNotification(for task: TaskModel) {
        guard let date = task.notifyTime else { return }

        let content = UNMutableNotificationContent()
        content.title = task.name
        content.body = task.detail ?? "You have a task due."
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        ), repeats: false)

        let request = UNNotificationRequest(
            identifier: task.id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    static func cancelNotification(for task: TaskModel) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
    }
}

