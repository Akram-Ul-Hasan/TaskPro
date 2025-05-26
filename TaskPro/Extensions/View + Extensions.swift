//
//  View + Extensions.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 25/5/25.
//

import SwiftUI

extension View {
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
