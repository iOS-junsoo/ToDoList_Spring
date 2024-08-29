//
//  AddViewController.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/28/24.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    let descriptionTextPlaceHolder = "내용을 작성해주세요."
    private lazy var apiServcie: APIServiceDelegate = APIServcie()
    
    @IBOutlet weak var addBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.delegate = self
        descriptionText.delegate = self
        doneBtn()
        
        

    }
    
    func doneBtn(){
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneBtnClicked))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        keyboardToolbar.sizeToFit()
        keyboardToolbar.tintColor = UIColor.systemGray

        titleText.inputAccessoryView = keyboardToolbar
        descriptionText.inputAccessoryView = keyboardToolbar
    }
    
    @IBAction func doneBtnClicked (sender: Any) {
        self.view.endEditing(true)
        if titleText.text == "" || descriptionText.text == descriptionTextPlaceHolder || descriptionText.text == "" {
            addBtn.isEnabled = false
        } else {
            addBtn.isEnabled = true
            
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if titleText.text == "" || descriptionText.text == descriptionTextPlaceHolder || descriptionText.text == "" {
            addBtn.isEnabled = false
        } else {
            addBtn.isEnabled = true
            apiServcie.addTodo(todo: Todo_Compact(title: titleText.text ?? "잘못된 Todo 제목", description: descriptionText.text ?? "잘못된 Todo 내용")) {
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                self.dismiss(animated: true)
            }
            
        }
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
        
    }
    

}

extension AddViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            if descriptionText.text == descriptionTextPlaceHolder {
                descriptionText.text = nil
                descriptionText.textColor = .black
            }
        }
  
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                descriptionText.text = descriptionTextPlaceHolder
                descriptionText.textColor = .lightGray

            }
        }
    

}
