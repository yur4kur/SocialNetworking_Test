//
//  DataManager.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 14.04.2023.
//

import Foundation

class DataManager {
    let coreDataManager = CoreDataManager.shared
    let networkManager = NetworkManager()
    
    func getAllUsers(_ completionHandler: @escaping ([User]) -> Void) {
        coreDataManager.getAllUsers { (users) in
            if users.count > 0 {
                print("\(users.count) from DB")
                completionHandler(users)
            } else {
                self.networkManager.getAllUsers { (users) in
                    self.coreDataManager.save(users: users) {
                        completionHandler(users)
                    }
                }
            }
        }
    }
}
