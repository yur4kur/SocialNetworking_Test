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
    var company: Company?
    
    struct Company: Codable {
        var name: String
        var catchPhrase: String
    }
    
//    init(id: Int, name: String, username: String, email: String)  {
//        self.id = id
//        self.name = name
//        self.username = username
//        self.email = email
//        self.company = Company(name: "", catchPhrase: "")
//    }
    
    
    init(entity: UserEntity) {
        self.id = Int(entity.id)
        self.name = entity.name ?? ""
        self.username = entity.username ?? ""
        self.email = entity.email ?? ""
        //self.company = nil
    }
}
