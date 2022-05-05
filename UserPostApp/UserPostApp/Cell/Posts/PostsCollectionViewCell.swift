//
//  PostsCollectionViewCell.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(model: Posts) {
        titleLabel.text = model.title

    }

    
    @IBAction func showMore(_ sender: Any) {

    }
    
}
