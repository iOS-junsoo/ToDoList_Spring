//
//  APIServiceDelegate.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/28/24.
//
import Foundation



protocol APIServiceDelegate: AnyObject{
    func getTodo(delegate: APISerivceResultDelegate)
    func addTodo(todo: Todo_Compact, completion: @escaping () -> Void)
    func completeTodo(id: Int, completion: @escaping () -> Void)
    func deleteTodo(id: Int)
}

protocol APISerivceResultDelegate {
    func getResult(_ result: [Todo])
}


	

