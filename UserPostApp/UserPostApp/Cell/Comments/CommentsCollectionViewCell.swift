//
//  CommentsCollectionViewCell.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
    }
    
    func configure(model: Comments){
        nameLabel.text = model.name
        mailLabel.text = model.email
        bodyTextView.text = model.body
    }

}
