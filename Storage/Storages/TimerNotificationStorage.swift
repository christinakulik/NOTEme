//
//  TimerNotificationStorage.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import CoreData

public final class TimerNotificationStorage:
    NotificationStorage<TimerNotificationDTO> {}

//public final class TimerNotificationStorage {
//    
//    public typealias CompletionHandler = (Bool) -> Void
//    
//    public init() {}
//    
//    //Fetch
//    public func fetch(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [TimerNotificationDTO] {
//        return fetchMO(predicate: predicate, sortDescriptors: sortDescriptors)
//            .compactMap { TimerNotificationDTO(mo: $0) }
//    }
//    
//    private func fetchMO(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [TimerNotificationMO] {
//        let request: NSFetchRequest<TimerNotificationMO> = 
//        TimerNotificationMO.fetchRequest()
//        let context = CoreDataService.shared.mainContext
//        let results = try? context.fetch(request)
//        return results ?? []
//    }
//    
//    //Create
//    public func create(dto: TimerNotificationDTO,
//                completion: CompletionHandler? = nil) {
//        let context = CoreDataService.shared.backgroundContext
//        context.perform {
//            let mo = TimerNotificationMO(context: context)
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(context: context, 
//                                               completion: completion)
//        }
//    }
//    
//    func update(dto: TimerNotificationDTO,
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
//            CoreDataService.shared.saveContext(context: context,
//                                               completion: completion)
//        }
//    }
//    
//    func updateOrCreate(dto: TimerNotificationDTO,
//                completion: CompletionHandler? = nil) {
//        if fetchMO(predicate:
//                .Notification.notification(byId: dto.identifier))
//            .isEmpty {
//            create(dto: dto, completion: completion)
//        } else {
//            update(dto: dto, completion: completion)
//        }
//    }
//}
