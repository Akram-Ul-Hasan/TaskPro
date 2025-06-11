//
//  CustomDatePicker.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 1/6/25.
//

import SwiftUI

struct CustomDatePickerView: View {
    @State private var taskDate = Date()
    @State private var showDatePicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date")
                .font(.caption)
                .foregroundColor(.gray)

            Button(action: {
                showDatePicker.toggle()
            }) {
                Text(formattedDate)
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
            }
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker("Select Date", selection: $taskDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorMultiply(.white)
                    .accentColor(.white)
                    .padding()
                Button("Done") {
                    showDatePicker = false
                }
                .padding()
            }
            .background(Color.black)
        }
        .padding()
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: taskDate)
    }
}
