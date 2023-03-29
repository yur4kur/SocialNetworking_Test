//
//  NetworkManager.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 21.03.2023.
//

import Foundation

class NetworkManager {
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    enum APIs: String {
        case users
        case posts
        case comments
    }
    
    func getAllUser(_ completionHandler: @escaping ([User]) -> Void) {
        
        guard let url = URL(string: baseURL + APIs.users.rawValue) else { return }
            
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("Error in request: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    guard let data = data else { return }
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        completionHandler(users)
                    } catch {
                        print("Error in decoding data: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    
    
    func getPostsByUser (userId: Int, _ completionHandler: @escaping ([Post]) -> Void) {
        
        guard let url = URL(string: baseURL + APIs.posts.rawValue) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
        
        guard let queryURL = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: queryURL) { data, response, error in
            
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completionHandler(posts)
                } catch {
                    print("Error in decoding data: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func getCommentsByPost(postId: Int, _ completionHandler: @escaping ([Comment]) -> Void) {
        
        guard let url = URL(string: baseURL + APIs.comments.rawValue) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "postId", value: "\(postId)")]
        
        guard let queryURL = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: queryURL) { data, response, error in
            
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let comments = try JSONDecoder().decode([Comment].self, from: data)
                    completionHandler(comments)
                } catch {
                    print("Error in decoding data: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
}
