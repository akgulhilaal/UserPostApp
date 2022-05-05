//
//  PostDetailViewModel.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import Foundation

protocol PostDetailViewModelProtocol {
    
    var delegate: PostDetailViewModelDelegate? { get set }
    func load()
    func details(index: Int) -> Posts?

}

protocol PostDetailViewModelDelegate: AnyObject {
    func reloadData()
}

final class PostDetailViewModel {
    
    static var posts :[Posts] = []
    var postDetail : [Posts] = []
    var postId : Int
    weak var delegate: PostDetailViewModelDelegate?
    
    init(postId: Int) {
        self.postId = postId
    }
    
    fileprivate func fetchDetails() {
        self.postDetail = PostDetailViewModel.posts.filter({(posts : Posts) -> Bool in
            return (posts.id == self.postId)})
        self.delegate?.reloadData()

    }
}

extension PostDetailViewModel : PostDetailViewModelProtocol{
    func details(index: Int) -> Posts? {
        postDetail[index]
    }
    
    func load() {
        fetchDetails()
    }
    
    
}
