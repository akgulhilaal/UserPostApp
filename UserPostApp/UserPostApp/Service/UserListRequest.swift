//
//  UserListRequest.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 5.04.2022.
//

import Foundation

enum UserListRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}


struct UserListRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://jsonplaceholder.typicode.com/users"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        self.resourceURL = resourceURL
    }
    func getUsers(completion : @escaping(Result<[UserList],UserListRequestError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userList = try decoder.decode([UserList].self, from: jsonData)
                completion(.success(userList))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
