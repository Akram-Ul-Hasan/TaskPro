//
//  UserSession.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 26/5/25.
//

import Foundation
import FirebaseAuth

class UserSession: ObservableObject {
    @Published var userId: String? = nil
    @Published var isSignedIn: Bool = false
    
    init() {
        if let user = Auth.auth().currentUser {
            self.userId = user.uid
            self.isSignedIn = true
        }
    }
    
    func clear() {
        userId = nil
        isSignedIn = false
    }
}
