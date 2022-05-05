//
//  PostsViewController.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: PostsViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.register(UINib(nibName: "PostsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }

    
}
extension PostsViewController : PostsViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension PostsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: collectionView.frame.width * 0.95, height: 100)
    
}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostsCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = #colorLiteral(red: 0.9562619328, green: 0.262994051, blue: 0.2056628466, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
        cell.showButton.tag = viewModel.posts(index: indexPath.row)!.id
        cell.showButton.addTarget(self, action: #selector(self.showDetails(sender: )), for: .touchUpInside)
        if let post = viewModel.posts(index: indexPath.row) {
            cell.configure(model: post)
        }
        return cell
    }
    @objc func showDetails(sender : UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let postViewModel = PostDetailViewModel(postId: sender.tag)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController {
            controller.detailViewModel = postViewModel
            controller.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(controller, animated: true)
           }
    }

    
    
}
