//
//  TimerNotificationStorage.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import CoreData

public final class TimerNotificationStorage:
    NotificationStorage<TimerNotificationDTO> {}

//    //Fetch
//    public func fetch(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [TimerNotificationDTO] {
//        return fetchMO(predicate: predicate, sortDescriptors: sortDescriptors)
//            .compactMap { TimerNotificationDTO(mo: $0) }
//    }
//    
