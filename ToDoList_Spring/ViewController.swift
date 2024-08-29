//
//  ViewController.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/28/24.
//

import UIKit
import Foundation

class ViewController: UIViewController, APISerivceResultDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    var todoList: [Todo] = []
    private lazy var apiServcie: APIServiceDelegate = APIServcie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiServcie.getTodo(delegate: self)
        setUpTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        dateLabel.text = getCurrentDateString()
         
    }
    @objc func reload() {
        apiServcie.getTodo(delegate: self)
    }
    
    func tableReload(){
        apiServcie.getTodo(delegate: self)
        tableView.reloadData()
    }
    
    func getResult(_ result: [Todo]) {
        todoList = result
        tableView.reloadData()
    }
    
    func setUpTableView(){
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
    }
    
    func getCurrentDateString() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func addStrikethrough(to label: UILabel, text: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        label.attributedText = attributedString
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.todoLabel.text = todoList[indexPath.row].title
        if todoList[indexPath.row].completed == true {
            cell.todoLabel.textColor = .lightGray
        } else {
            cell.todoLabel.textColor = .black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            // 삭제 버튼을 눌렀을 때 데이터 삭제 처리
            self.apiServcie.deleteTodo(id: self.todoList[indexPath.row].id)
            self.todoList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)

        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "완료") { (action, view, completionHandler) in
            self.apiServcie.completeTodo(id: self.todoList[indexPath.row].id) {
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                completionHandler(true)
            }
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true

        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click \(indexPath.row) / \(todoList[indexPath.row])")

//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let detailVC = storyboard.instantiateViewController(withIdentifier: "TodoDetailViewController") as? TodoDetailViewController {
//            detailVC.detail_title = todoList[indexPath.row].title
//            detailVC.detail_description = todoList[indexPath.row].description
//            detailVC.modalPresentationStyle = .fullScreen
//            self.present(detailVC, animated: true)
//        }
        
        
//        let detailVC = TodoDetailViewController(title: todoList[indexPath.row].title, description: todoList[indexPath.row].description)
//        detailVC.modalPresentationStyle = .fullScreen // 또는 .pageSheet, .formSheet 등
//        self.present(detailVC, animated: true, completion: nil)

        
    }
    
}


