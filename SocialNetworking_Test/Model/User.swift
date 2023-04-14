//
//  User.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 21.03.2023.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var company: Company
    
    struct Company: Codable {
        var name: String
        var catchPhrase: String
    }
}
