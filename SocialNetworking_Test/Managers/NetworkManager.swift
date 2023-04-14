//
//  NetworkManager.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 21.03.2023.
//

import Foundation

class NetworkManager {
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    enum HTTPHeaders: String {
        case length = "Content-Length"
        case type = "Content-Type"
    }
    
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
    
    // MARK: -  POST methods
    func createPost(_ post: Post, _ completionHandler: @escaping (Post) -> Void){
        
        guard let url = URL(string: baseURL + APIs.posts.rawValue),
        let sentPost = try? JSONEncoder().encode(post) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = sentPost
        request.setValue("\(sentPost.count)", forHTTPHeaderField: HTTPHeaders.length.rawValue)
        request.setValue("application/json", forHTTPHeaderField: HTTPHeaders.type.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                guard let data = data else { return }
                do{
                    let returnedPost = try JSONDecoder().decode(Post.self, from: data)
                    completionHandler(returnedPost)
                } catch {
                    print("Error while creating post")
                }
            }
        }
        task.resume()
    }
    
    func createComment(_ comment: Comment, _ completionHandler: @escaping (Comment) -> Void) {
        
        guard let url = URL(string: baseURL + APIs.comments.rawValue),
        let sentComment = try? JSONEncoder().encode(comment) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = sentComment
        request.setValue("\(sentComment.count)", forHTTPHeaderField: HTTPHeaders.length.rawValue)
        request.setValue("application/json", forHTTPHeaderField: HTTPHeaders.type.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                guard let data = data else { return }
                do {
                    let returnedComment = try JSONDecoder().decode(Comment.self, from: data)
                    completionHandler(returnedComment)
                } catch {
                    print("Error while creating comment")
                }
            }
        }
        task.resume()
    }
    
    // MARK: -  DELETE methods
    func deletePost(_ post: Post, _ completionHandler: @escaping(Post) -> Void) {
        
            guard let url = URL(string: baseURL + APIs.posts.rawValue),
              let deletedPost = try? JSONEncoder().encode(post) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.httpBody = deletedPost
        request.setValue("\(deletedPost.count)", forHTTPHeaderField: HTTPHeaders.length.rawValue)
        request.setValue("application/json", forHTTPHeaderField: HTTPHeaders.type.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 204 || response.statusCode == 200  {
                if let data = data {
                    if let wipedPost = try? JSONDecoder().decode(Post.self, from: data) {
                        completionHandler(wipedPost)
                        print(wipedPost.id)
                    }
                }
            }
        }
        task.resume()
    }
    
    func deleteComment(_ comment: Comment, _ completionHandler: @escaping (Comment) -> Void) {
        
        guard let url = URL(string: baseURL + APIs.comments.rawValue),
              let deletedComment = try? JSONEncoder().encode(comment) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.httpBody = deletedComment
        request.setValue("\(deletedComment.count)", forHTTPHeaderField: HTTPHeaders.length.rawValue)
        request.setValue("application/json", forHTTPHeaderField: HTTPHeaders.type.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 204 || response.statusCode == 200 {
                if let data = data {
                    if let wipedComment = try? JSONDecoder().decode(Comment.self, from: data) {
                        completionHandler(wipedComment)
                    }
                }
            }
        }
        task.resume()
    }
}
