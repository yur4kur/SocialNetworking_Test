//
//  UserEntity.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 14.04.2023.
//

import Foundation
import CoreData

class UserEntity: NSManagedObject {
    
    class func findOrCreate(_ user: User, _ context: NSManagedObjectContext) throws -> UserEntity {
        
        //        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        //        request.predicate = NSPredicate(format: "id == %d", user.id)
        //
        //        do {
        //            let fetchResult = try context.fetch(request)
        //            //Проверяем на дубликаты в базе данных
        //            if fetchResult.count > 0 {
        //                assert(fetchResult.count == 1, "Duplicate has been found in DB")
        //                return fetchResult[0]
        //            }
        //
        //        } catch {
        //            throw error
        //        }
        
        if let userEntity = try? UserEntity.findUser(userId: user.id, context: context) {
            return userEntity
        } else {
            let userEntity = UserEntity(context: context)
           userEntity.id = Int64(user.id)
           userEntity.name = user.name
           userEntity.username = user.username
           userEntity.email = user.email
           
           return userEntity
        }
    }
    
    class func all(_ context: NSManagedObjectContext) throws -> [UserEntity] {
       
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
    
    class func findUser(userId: Int, context: NSManagedObjectContext) throws -> UserEntity? {
        
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", userId)
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                assert(result.count == 1, "Duplicates in UserEntity")
                return result[0]
            }
        } catch {
            throw error
        }
        
        return nil
        
    }
    
}
