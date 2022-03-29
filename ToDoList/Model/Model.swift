//
//  Model.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 24/03/2022.
//

import UIKit
import CoreData

protocol Database {
    func addObject()
    func saveObject()
    func fetchObjects()
    func deleteObject()
}


enum FetchResult<T> {
    case success([T])
    case failure (Error)
}


class Model: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addObject<T: NSManagedObject>(entityType: T.Type) -> T {
        let newCategory = entityType.init(context: context)
        return newCategory
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
            let categories = try context.fetch(fetchRequest)
            completion(.success(categories))
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
        fetchRequest.predicate = predicate
        let batchDeletedRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeletedRequest)
        } catch {
            print("Error removing all Items \(error)")
        }
    }
}
