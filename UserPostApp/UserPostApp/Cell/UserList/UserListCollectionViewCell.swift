//
//  UserListCollectionViewCell.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 7.04.2022.
//

import UIKit

class UserListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(model: UserList) {
        name.text = model.name
        userName.text = model.username
    }

}
