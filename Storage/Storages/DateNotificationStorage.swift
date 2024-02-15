//
//  DateNotificationStorage.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//

import CoreData

public final class DateNotificationStorage: 
    NotificationStorage<DateNotificationDTO> {}

//    //Fetch
//    public func fetch(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [DateNotificationDTO] {
//        return fetchMO(predicate: predicate, sortDescriptors: sortDescriptors)
//            .compactMap { DateNotificationDTO(mo: $0) }
//    }
