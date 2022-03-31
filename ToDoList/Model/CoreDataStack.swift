//
//  Model.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 24/03/2022.
//

import UIKit
import CoreData
//
//protocol Database {
//    func addObject<T: NSManagedObject>(entityType: T.Type) -> T
//    func saveObject()
//    func fetchObjects<T: NSManagedObject>(entityName: T.Type, predicate: NSPredicate?, completion: @escaping (FetchResult<T>) -> Void)
//    func deleteObject<T: NSManagedObject>(_ object: T)
//}

enum FetchResult<T> {
    case success([T])
    case failure (Error)
}
//let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//extension NSManagedObject: Database {
//
//    func addObject<T>(entityType: T.Type) -> T where T : NSManagedObject {
//        let newObject = entityType.init(context: context)
//        return newObject
//    }
//
//    func saveObject() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//    func fetchObjects<T>(entityName: T.Type, predicate: NSPredicate?, completion: @escaping (FetchResult<T>) -> Void) where T : NSManagedObject {
//        let entityName = String(describing: entityName)
//        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
//        if let predicate = predicate {
//            fetchRequest.predicate = predicate
//        }
//        do {
//            let objects = try context.fetch(fetchRequest)
//            completion(.success(objects))
//        } catch {
//            completion(.failure(error))
//        }
//    }
//
//    func deleteObject<T>(_ object: T) where T : NSManagedObject {
//        context.delete(object)
//    }
//}

class CoreDataStack: NSObject {
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func addObject<T: NSManagedObject>(entityType: T.Type) -> T {
        let newObject = entityType.init(context: context)
        return newObject
    }
    /// new method, better than above one
    func create<T: NSManagedObject>(type: T.Type) -> T? {
        var newObject: T?
        if let entity = NSEntityDescription.entity(forEntityName: T.description(), in: context) {
            newObject = T(entity: entity, insertInto: context)
        }
        return newObject
    }
    
    func saveObject() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchObjects<T: NSManagedObject>(entityName: T.Type, predicate: NSPredicate?, completion: @escaping (FetchResult<T>) -> Void) {
        let entityName = String(describing: entityName)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        do {
            let objects = try context.fetch(fetchRequest)
            completion(.success(objects))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteObject<T: NSManagedObject>(_ object: T) {
        context.delete(object)
    }
    
    func deleteAllObjects<T: NSManagedObject>(entityName: T.Type, predicate: NSPredicate?) {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let entityName = String(describing: entityName)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        let batchDeletedRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeletedRequest)
        } catch {
            print("Error removing all Items \(error)")
        }
    }
}
