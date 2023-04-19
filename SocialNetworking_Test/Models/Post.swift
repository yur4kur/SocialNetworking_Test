//
//  Post.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 27.03.2023.
//

import Foundation

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
//    init(userId: Int, id: Int, title: String, body: String) {
//        self.userId = userId
//        self.id = id
//        self.title = title
//        self.body = body
//    }
}
