//
//  String +Extensions.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 22/5/25.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
