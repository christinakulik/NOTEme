//
//  NSPredicate+Consts.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//

import CoreData

public extension NSPredicate {
    
    enum Notification {
        public static var allNotCompleted: NSPredicate {
            let completedDateKeyPath = #keyPath(BaseNotificationMo.completedDate)
            return .init(format: "\(completedDateKeyPath) == NULL")
        }
        
       public static func notification(byId id: String) -> NSPredicate {
            let idKeyPath = #keyPath(BaseNotificationMo.identifier)
            return .init(format: "\(idKeyPath) CONTAINS[cd] %@", id)
        }
        
    }
    
}
