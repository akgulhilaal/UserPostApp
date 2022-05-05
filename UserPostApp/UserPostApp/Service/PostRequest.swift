//
//  PostRequest.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 5.04.2022.
//

import Foundation

enum PostRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}
struct PostRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://jsonplaceholder.typicode.com/posts"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        self.resourceURL = resourceURL
    }
    func getPosts(completion : @escaping(Result<[Posts],PostRequestError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Posts].self, from: jsonData)
                completion(.success(posts))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}

