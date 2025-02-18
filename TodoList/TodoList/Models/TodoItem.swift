//
//  TodoItem.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/19/25.
//

import Foundation

struct TodoItem: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var date: Date
    
    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        date: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.date = date
    }
}

// MARK: - Hashable
extension TodoItem {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        lhs.id == rhs.id
    }
}
