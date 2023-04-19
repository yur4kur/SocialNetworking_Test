//
//  CoreDataManager.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 14.04.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //!!! Записывает static var, чтобы было удобно создавать контейнеры в других файлах
    //static var container: NSPersistentContainer {
    //    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    //}
    
    static let shared = CoreDataManager()
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DataBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func getAllUsers(_ completionHandler: @escaping ([User]) -> Void) {
        let viewContext = persistentContainer.viewContext
            viewContext.perform {
                let userEntities = try? UserEntity.all(viewContext)
                let users = userEntities?.map ({ User(entity: $0) })
                //({ User(entity: $0) })
//                { users in
//                    User(entity: users[0])
//                }
                completionHandler(users ?? [])
            }
    }
    
    func save(users: [User], _ completionHandler: @escaping () -> ()) -> () {
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            for user in users {
               _ = try? UserEntity.findOrCreate(user, viewContext)
            }
            try? viewContext.save()
            
            completionHandler()
        }
    }
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
}
