//
//  CommentsRequest.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 5.04.2022.
//

import Foundation

enum CommentRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}
struct CommentsRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://jsonplaceholder.typicode.com/comments"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        self.resourceURL = resourceURL
    }
    func getComments(completion : @escaping(Result<[Comments],CommentRequestError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comments].self, from: jsonData)
                completion(.success(comments))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}


