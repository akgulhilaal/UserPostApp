//
//  CommentsViewController.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import UIKit

class CommentsViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var commentsViewModel: CommentsViewModelProtocol! {
        didSet {
            commentsViewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsViewModel.delegate = self
        collectionView.register(UINib(nibName: "CommentsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "commentsCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        commentsViewModel.load()
    }
}

extension CommentsViewController : CommentsViewModelDeletage{
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}
extension CommentsViewController : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        commentsViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: collectionView.frame.width * 0.95, height: 200)
    
}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentsCell", for: indexPath) as! CommentsCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
        if let comments = commentsViewModel.comments(index: indexPath.row) {
            cell.configure(model: comments)
        }
        return cell
    }
    
    
}
