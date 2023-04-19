//
//  Comments.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 28.03.2023.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
