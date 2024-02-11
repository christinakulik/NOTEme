//
//  LocationNotificationStorage.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import CoreData

public final class LocationNotificationStorage {
    
    typealias CompletionHandler = (Bool) -> Void
    
    public init() {}
    
    //Fetch
//    public func fetch(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [LocationNotificationDTO] {
//        return fetchMO(predicate: predicate, sortDescriptors: sortDescriptors)
//            .compactMap { LocationNotificationDTO(mo: $0) }
//    }
//    
//    private func fetchMO(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [LocationNotificationMO] {
//        let request: NSFetchRequest<LocationNotificationMO> = 
//        LocationNotificationMO.fetchRequest()
//        let context = CoreDataService.shared.mainContext
//        let results = try? context.fetch(request)
//        return results ?? []
//    }
//    
//    //Create
//    func create(dto: LocationNotificationDTO,
//                completion: CompletionHandler? = nil) {
//        let context = CoreDataService.shared.backgroundContext
//        context.perform {
//            let mo = LocationNotificationMO(context: context)
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(context: context, completion: completion)
//        }
//    }
//    
//    func update(dto: LocationNotificationDTO,
//                completion: CompletionHandler? = nil) {
//        let context = CoreDataService.shared.backgroundContext
//        context.perform { [weak self] in
//            guard
//                let mo = self?.fetchMO(predicate:
//                        .Notification.notification(byId: dto.identifier))
//                    .first
//            else { return }
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(context: context, completion: completion)
//        }
//    }
//    
//    func updateOrCreate(dto: LocationNotificationDTO,
//                completion: CompletionHandler? = nil) {
//        if fetchMO(predicate:
//                .Notification.notification(byId: dto.identifier))
//            .isEmpty {
//            create(dto: dto, completion: completion)
//        } else {
//            update(dto: dto, completion: completion)
//        }
//    }
}
