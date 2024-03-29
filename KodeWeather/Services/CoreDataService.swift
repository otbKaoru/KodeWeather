//
//  CoreDataService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation
import CoreData

final class CoreDataService: NSObject {

    static let shared = CoreDataService()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Attraction")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func fetchDataWithPredicate<T: NSFetchRequestResult>(predicateFormat: String?, predicateValue: String) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        if let predicateFormat = predicateFormat {
            fetchRequest.predicate = NSPredicate(format: predicateFormat, predicateValue)
        }
        do {
            let fetchedObjects = try persistentContainer.viewContext.fetch(fetchRequest)
            return fetchedObjects
        } catch {
            print("Error")
        }
        return []
    }

    func clearData() {
        do {
            let context = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Attraction.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                saveContext()
            } catch let error {
                print("ERROR DELETING: \(error)")
            }
        }
        do {
            let context = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Geo.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                saveContext()
            } catch let error {
                print("ERROR DELETING: \(error)")
            }
        }
    }

    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print("ERRO SAVE CONTEXT: \(error)")
            }
        }
    }
}
