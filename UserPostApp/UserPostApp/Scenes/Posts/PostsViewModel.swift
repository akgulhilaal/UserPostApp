//
//  PostsViewModel.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import Foundation

protocol PostsViewModelProtocol {
    
    var delegate: PostsViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func load()
    func posts(index: Int) -> Posts?

}

protocol PostsViewModelDelegate: AnyObject {
    func reloadData()
}

final class PostsViewModel {
    
    private var posts : [Posts] = []
    let service = PostRequest()
    var userId : Int
    weak var delegate: PostsViewModelDelegate?
    
    init(userId: Int) {
        self.userId = userId
    }
    
    
    fileprivate func fetchPosts() {
        service.getPosts{ [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let posts):
                self.posts = posts.filter({(posts : Posts) -> Bool in
                    return (posts.userId == self.userId)})
                PostDetailViewModel.posts = self.posts
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }

    }
}

extension PostsViewModel: PostsViewModelProtocol {

    
    var numberOfItems: Int {
        posts.count
    }

    func load() {
        fetchPosts()
    }
    
    func posts(index: Int) -> Posts? {
        posts[index]
    }
    
    
}
