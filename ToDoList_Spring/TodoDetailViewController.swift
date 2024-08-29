//
//  TodoDetailViewController.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/29/24.
//

import UIKit

class TodoDetailViewController: UIViewController {

    var detail_title: String
    var detail_description: String
    
    init(title: String, description: String) {
        
        self.detail_title = title
        self.detail_description = description
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("로드됨")
    }
    


}
