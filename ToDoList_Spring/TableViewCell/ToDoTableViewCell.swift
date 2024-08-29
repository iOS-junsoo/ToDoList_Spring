//
//  ToDoTableViewCell.swift
//  ToDoList_Spring
//
//  Created by 준수김 on 8/28/24.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!
    var id: Int = 0
    private lazy var apiServcie: APIServiceDelegate = APIServcie()
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func getId(with id: Int) {
        self.id = id
    }
    

}
