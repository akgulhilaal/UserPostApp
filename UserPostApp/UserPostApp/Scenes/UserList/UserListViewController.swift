//
//  ViewController.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 4.04.2022.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "UserListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCell")
        viewModel.delegate = self


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }

}
extension UserListViewController : ViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension UserListViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: collectionView.frame.width * 0.95, height: 80)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCell", for: indexPath) as! UserListCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = #colorLiteral(red: 0.9562619328, green: 0.262994051, blue: 0.2056628466, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
        if let users = viewModel.user(index: indexPath.row) {
            cell.configure(model: users)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postViewModel = PostsViewModel(userId: viewModel.user(index: indexPath.row)!.id)
        let postVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        postVC.viewModel = postViewModel
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    
}
