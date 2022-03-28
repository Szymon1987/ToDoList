//
//  Model.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 24/03/2022.
//

import UIKit
import CoreData

protocol Database {
    func saveContext()
    func fetchPersistendData()
    func remove()
    func rename()
}


enum FetchResult<T> {
    case success([T])
    case failure (Error)
}


class Model: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func fetchPersistendData(completion: @escaping (FetchCategoryResult) -> Void) {
//
//        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            let categories = try context.fetch(fetchRequest)
//            completion(.success(categories))
//        } catch {
//            completion(.failure(error))
//        }
//
//    }
    
    func fetchPersistendData<T: NSManagedObject>(entityName: T.Type, completion: @escaping (FetchResult<T>) -> Void) {
        
        let entityName = String(describing: entityName)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            let categories = try context.fetch(fetchRequest)
            completion(.success(categories))
        } catch {
            completion(.failure(error))
        }

    }
    
    
    
//    
//    func remove() {
//        
//    }
//    
//    func rename() {
//        
//    }
    
    
}
