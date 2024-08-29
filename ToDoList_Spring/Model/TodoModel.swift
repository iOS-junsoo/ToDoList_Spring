//
//  TodoModl.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/28/24.
//

import Foundation
struct Todo: Codable {
    let id: Int
    let title: String
    let description: String
    let completed: Bool
}

struct Todo_Compact: Codable {
    let title: String
    let description: String
}

struct TodoList: Codable {
    let todos: [Todo]
}
