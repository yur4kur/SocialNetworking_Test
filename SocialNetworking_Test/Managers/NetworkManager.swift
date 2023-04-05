//
//  NetworkManager.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 21.03.2023.
//

import Foundation

class NetworkManager {
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    enum HTTPMethod: String {
        case post
        case delete
    }
    
    enum APIs: String {
        case users
        case posts
        case comments
    }
    
    // MARK: - GET methods
    func getAllUsers(_ completionHandler: @escaping ([User]) -> Void) {
        
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
    
    // MARK: POST methods
    func createPost(_ post: Post, _ completionHandler: @escaping (Post) -> Void){
        
        guard let url = URL(string: baseURL + APIs.posts.rawValue),
        let sentPost = try? JSONEncoder().encode(post) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = sentPost
        request.setValue("\(sentPost.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                if let data = data {
                    if let returnedPost = try? JSONDecoder().decode(Post.self, from: data) {
                        completionHandler(returnedPost)
                    }
                }
            }
        }
        task.resume()
    }
    
}
