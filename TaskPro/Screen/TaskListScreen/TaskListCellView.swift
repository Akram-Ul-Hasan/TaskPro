//
//  TaskListCellView.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//

import SwiftUI

struct TaskListCellView: View {
    
    var list : TaskListModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(list.title)
                .font(.headline)
            Text("\(list.tasks.count) tasks")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}



