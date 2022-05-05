//
//  PostDetailViewController.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import UIKit

class PostDetailViewController: UIViewController{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var detailViewModel: PostDetailViewModelProtocol! {
        didSet {
            detailViewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailViewModel.load()


    }
    @IBAction func showComments(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let commentsViewModel = CommentsViewModel(postId: (self.detailViewModel.details(index: 0)?.id)!)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController {
            controller.commentsViewModel = commentsViewModel
            controller.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(controller, animated: true)
           }
    }
    
}
extension PostDetailViewController : PostDetailViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.titleLabel.text = (self.detailViewModel.details(index: 0)?.title)!.uppercased()
            self.bodyTextView.text = (self.detailViewModel.details(index: 0)?.body)!
        }
    }
    
}
