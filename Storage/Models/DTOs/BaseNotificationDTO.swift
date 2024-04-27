//
//  BaseNotificationDTO.swift
//  Storage
//
//  Created by Christina on 13.02.24.
//

import Foundation
import CoreData

public struct BaseNotificationDTO: DTODescription {
    
    public typealias MO = BaseNotificationMo
    
    public var date: Date
    public var identifier: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    
    public init(date: Date,
                identifier: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil) {
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
    }
    
    public static func fromMO(_ mo: MO) -> BaseNotificationDTO? {
        guard
            let identifier = mo.identifier,
            let title = mo.title,
            let date = mo.date
        else { return nil }
        
        return BaseNotificationDTO(date: date,
                                   identifier: identifier,
                                   title: title,
                                   subtitle:  mo.subtitle,
                                   completedDate: mo.completedDate)
    }
    
    public func createMO(context: NSManagedObjectContext) -> BaseNotificationMo? {
        let mo = BaseNotificationMo(context: context)
        mo.apply(dto: self)
        return mo
    }
}
