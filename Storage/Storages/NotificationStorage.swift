//
//  NotificationStorage.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import Foundation
import CoreData

public class NotificationStorage<DTO: DTODescription> {
    
    public typealias CompletionHandler = (Bool) -> Void
    
    public init() {}
    
    public func fetch(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []) -> [any DTODescription] {
            return fetchMO(predicate: predicate, sortDescriptors: sortDescriptors)
                .compactMap { $0.toDTO() }
        }
    
    private func fetchMO(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [DTO.MO] {
        let request = NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        let context = CoreDataService.shared.mainContext
        
        let results = try? context.fetch(request)
        return results ?? []
    }
    
    //Create
    public func create(dto: DTO,
                       completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        context.perform {
            let mo = DTO.MO(context: context)
            mo.apply(dto: dto)
            print("Creating MO: \(mo)")
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    
    public func update(dto: DTO,
                completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        context.perform { [weak self] in
            guard
                let mo = self?.fetchMO(predicate:
                        .Notification.notification(byId: dto.identifier))
                    .first
            else { return }
            mo.apply(dto: dto)
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    
    func updateOrCreate(dto: DTO,
                        completion: CompletionHandler? = nil) {
        if fetchMO(predicate:
                .Notification.notification(byId: dto.identifier)).isEmpty {
            create(dto: dto, completion: completion)
        } else {
            update(dto: dto, completion: completion)
        }
    }
    
    public func delete(dto: any DTODescription,
                       completion: CompletionHandler? = nil) {
        let context = CoreDataService.shared.mainContext
        context.perform { [weak self] in
            guard let mo = self?.fetchMO(predicate:
                    .Notification.notification(byId: dto.identifier)).first
            else { return }
            context.delete(mo)
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
}



