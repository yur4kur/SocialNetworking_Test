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
}
