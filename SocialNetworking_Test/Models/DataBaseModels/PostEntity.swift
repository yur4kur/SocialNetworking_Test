//
//  PostEntity.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 19.04.2023.
//

import Foundation
import CoreData

class PostEntity: NSManagedObject {
    
    // Результат функции optional, т.к. если нет пользователя, то пост не создаем
    class func findOrCreate(_ post: Post, context: NSManagedObjectContext) throws -> PostEntity? {
        
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", post.id)
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                assert(result.count == 1, "Duplicates in PostEntity")
                return result[0]
            }
            
            if let userEntity = try UserEntity.findUser(userId: post.userId, context: context) {
                
                let postEntity = PostEntity(context: context)
                postEntity.user = userEntity
                postEntity.id = Int64(post.id)
                postEntity.userId = Int64(post.userId)
                postEntity.title = post.title
                postEntity.body = post.body
                
                return postEntity
            }
            
        } catch {
            throw error
        }
        return nil
    }
}
