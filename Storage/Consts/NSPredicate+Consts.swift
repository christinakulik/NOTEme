//
//  NSPredicate+Consts.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//

import CoreData

extension NSPredicate {
    
    enum Notification {
        
        static func notification(byId id: String) -> NSPredicate {
            let idKeyPath = #keyPath(BaseNotificationMo.identifier)
            return .init(format: "\(idKeyPath) CONTAINS[cd] %@", id)
        }
        
    }
    
}
