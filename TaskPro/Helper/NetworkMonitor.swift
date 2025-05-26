//
//  NetworkMonitor.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 26/5/25.
//

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    var isConnected: Bool = false

    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            if self.isConnected {
                TaskSyncManager.shared.syncPendingTasks()
            }
        }
        monitor.start(queue: queue)
    }
}
