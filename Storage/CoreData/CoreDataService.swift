//
//  CoreDataService.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//

import CoreData

final class CoreDataService {
    
    static var shared: CoreDataService = .init()
    private init() {}
    
    lazy var mainContext: NSManagedObjectContext = {
            let context = persistentContainer.viewContext
            context.automaticallyMergesChangesFromParent = true
            return context
        }()
        
        var backgroundContext: NSManagedObjectContext {
            return persistentContainer.newBackgroundContext()
        }
 
    private var persistentContainer: NSPersistentContainer = {
            let modelName = "NotificationDataBase"
            let bundle = Bundle(for: CoreDataService.self)
            
            guard
                let modelURL = bundle.url(forResource: modelName, 
                                          withExtension: "momd"),
                let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
            else { fatalError("unable to find model in bundle") }

            let container = NSPersistentContainer(name: modelName,
                                                  managedObjectModel: managedObjectModel)
            
            container.loadPersistentStores(completionHandler: { 
                (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    func saveMainContext(completion: ((Bool) -> Void)? = nil) {
        saveContext(context: mainContext, completion: completion)
    }
    
    func saveContext (context: NSManagedObjectContext,
                      completion: ((Bool) -> Void)? = nil) {
        if context.hasChanges {
            do {
                try context.save()
                completion?(true)
            } catch {
                let nserror = error as NSError
                completion?(false)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
