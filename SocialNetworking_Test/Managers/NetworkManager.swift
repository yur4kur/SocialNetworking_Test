//
//  NetworkManager.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 21.03.2023.
//

import Foundation

class NetNetworkManager {
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    enum APIs: String {
        case users
        case posts
        case comments
    }
    
    func getAllUser(_ completionHandler: @escaping ([User]) -> Void) {
        if let url = URL(string: baseURL + APIs.users.rawValue) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("Error in request: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    guard let data = data else {
                        return
                    }
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        completionHandler(users)
                    } catch {
                        print("Error in decoding data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
}
