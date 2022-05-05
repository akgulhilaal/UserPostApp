//
//  CommentsViewModel.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 8.04.2022.
//

import Foundation

protocol CommentsViewModelProtocol {
    var delegate: CommentsViewModelDeletage? {get set}
    var numberOfItems: Int { get }
    func load()
    func comments(index: Int) -> Comments?
}

protocol CommentsViewModelDeletage : AnyObject {
    func reloadData()
}

final class CommentsViewModel {
    
    private var comments : [Comments] = []
    let service = CommentsRequest()
    var postId : Int
    weak var delegate : CommentsViewModelDeletage?
    
    init(postId : Int){
        self.postId = postId
    }
    
    fileprivate func fetchComments(){
        service.getComments{[weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let comments):
                self.comments = comments.filter({(comments : Comments) -> Bool in
                    return (comments.postId == self.postId)})
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }

    
}
extension CommentsViewModel : CommentsViewModelProtocol {
    var numberOfItems: Int {
        comments.count
    }
    
    func load() {
        fetchComments()
    }
    
    func comments(index: Int) -> Comments? {
        comments[index]
    }
    
    
}
