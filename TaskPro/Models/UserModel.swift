//
//  UserModel.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 27/5/25.
//

import Foundation

enum UserType: String, Codable {
    case guest
    case loggedIn
}

struct UserModel: Codable {
    let uid: String
    let name: String
    let email: String?
    let photoURL: URL?
    let userType: UserType
}

