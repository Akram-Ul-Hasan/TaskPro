//
//  TaskListSortView.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 22/5/25.
//

import SwiftUI

enum TaskListSortType: String, CaseIterable, Identifiable {
    case none
    case date
    case title

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .none:
            return "None"
        case .date:
            return "Date"
        case .title:
            return "Title"
        }
    }
}

struct TaskListSortView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sort by")
                .font(.headline)
                .padding(.bottom, 4)
            
            VStack(spacing: 10) {
                ForEach(TaskListSortType.allCases) { type in
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 10)
                        Text(type.title)
                            .font(.body)
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
            }
        }
        .padding()
    }
    
}

#Preview {
    TaskListSortView()
}
