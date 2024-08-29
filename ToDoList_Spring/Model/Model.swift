//
//  Model.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/28/24.
//

import Foundation
struct Todo: Decodable {
    let id: Int
    let title: String
    let description: String
    let completed: Bool
}
