//
//  CommentsModel.swift
//  UserPostApp
//
//  Created by Hilal Akgül on 5.04.2022.
//

import Foundation

struct Comments: Codable {
    let postId, id: Int
    let name, email, body: String

}



