//
//  NSSordDescroptor+Const.swift
//  Storage
//
//  Created by Christina on 20.02.24.
//

import Foundation
import CoreData

public extension NSSortDescriptor {
    
    enum Notification {
        public static var byDate: NSSortDescriptor {
            let dateKeyPath = #keyPath(BaseNotificationMo.date)
            return .init(key: dateKeyPath, ascending: false)
        }
        
        public static var byCompleted: NSSortDescriptor {
            let completedKeyPath = #keyPath(BaseNotificationMo.completedDate)
            return .init(key: completedKeyPath, ascending: true)
        }
    }
}
