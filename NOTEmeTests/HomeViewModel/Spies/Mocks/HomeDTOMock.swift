//
//  HomeDTOMock.swift
//  NOTEmeTests
//
//  Created by Christina on 26.03.24.
//

import Foundation
import Storage
import CoreData

struct HomeDTOMock: DTODescription {
    
    typealias MO = BaseNotificationMo
    
    var identifier: String = "test id"
    
    var date: Date = .init()
    
    var title: String = "test tile"
    
    var subtitle: String? = "test subtitle"
    
    var completedDate: Date? = nil
    
    static func fromMO(_ mo: Storage.BaseNotificationMo) -> HomeDTOMock? {
        return nil
    }

    
}
