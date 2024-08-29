//
//  APIServcie.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/28/24.
//

import Foundation
import Alamofire



class APIServcie: APIServiceDelegate {
    
    private let BASE_URL = "http://192.168.219.106:8080/todo"
    
    func getTodo(delegate: APISerivceResultDelegate) {
        AF.request(BASE_URL,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Todo].self) { [weak self] response in
                            switch response.result {
                            case .success(let todoList):
                                // JSON 데이터가 성공적으로 디코딩되었을 때
                                print("성공 - getTodo: \(todoList)")
                                delegate.getResult(todoList)
                                
                            case .failure(let error):
                                // JSON 데이터 디코딩 실패
                                print("실패 - getTodo: \(error)")
                            }
                        }
        
    }
    
    func addTodo(todo: Todo_Compact, completion: @escaping () -> Void) {
      
        let parameters: [String: String] = [
                "title": todo.title,
                "description": todo.description
            ]

        AF.request(BASE_URL,
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder(),
                    headers: ["Content-Type":"application/json; charset=utf-8"] )
            .validate()
            .responseJSON { response in

            switch response.result {
            case .success(let response):
                print("DEBUG>> Success \(response) ")
                completion()
            case .failure(let error):
                print("DEBUG>> Error : \(error.localizedDescription)")
            }

        }
    }
    
    func completeTodo(id: Int, completion: @escaping () -> Void) {
        let URL = BASE_URL + "/\(id)/complete"

        AF.request(URL,
                    method: .put,
                    parameters: nil,
                    encoding: JSONEncoding.default,
                    headers: ["Content-Type":"application/json; charset=utf-8"] )
            .validate()
            .responseJSON { response in

            switch response.result {
            case .success(let response):
                print("DEBUG>> Success- complete \(response) ")
                completion()
            case .failure(let error):
                print("DEBUG>> Error- complete : \(error.localizedDescription)")
            }

        }
    }
    
    func deleteTodo(id: Int) {
        let URL = BASE_URL + "/\(id)/delete"
        print("delete: \(id)")
        AF.request(URL,
                    method: .delete,
                    parameters: nil,
                    encoding: JSONEncoding.default,
                    headers: ["Content-Type":"application/json; charset=utf-8"] )
            .validate()
            .responseJSON { response in

            switch response.result {
            case .success(let response):
                print("DEBUG>> 삭제 성공, 응답 데이터 없음")
            case .failure(let error):
                print("DEBUG>> 삭제 실패 또는 응답 없음")
            }

        }
      
    }
    
}
