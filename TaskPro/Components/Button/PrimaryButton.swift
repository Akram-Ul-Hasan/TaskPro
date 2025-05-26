//
//  PrimaryButton.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 21/5/25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(isDisabled ? Color.white.opacity(0.7) : .white)
                .background(isDisabled ? Color.gray : Color.blue)
                .cornerRadius(12)
                .shadow(color: isDisabled ? .clear : Color.blue.opacity(0.3), radius: 6, x: 0, y: 4)
                .animation(.easeInOut(duration: 0.2), value: isDisabled)
        }
        .disabled(isDisabled)
    }
}
