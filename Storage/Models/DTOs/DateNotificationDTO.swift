//
//  DateNotificationDTO.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//

import Foundation
import CoreData

public struct DateNotificationDTO: DTODescription {

    public typealias MO = DateNotificationMO

    public var date: Date
    public var identifier: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var targetDate: Date
    
    public init(date: Date,
                identifier: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                targetDate: Date) {
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.targetDate = targetDate
    }

    public static func fromMO(_ mo: DateNotificationMO) -> DateNotificationDTO? {
            guard
                let identifier = mo.identifier,
                let title = mo.title,
                let date = mo.date,
                let targetDate = mo.targetDate
            else { return nil }
            
            return DateNotificationDTO(date: date, 
                                       identifier: identifier,
                                       title: title,
                                       subtitle: mo.subtitle,
                                       completedDate: mo.completedDate,
                                       targetDate: targetDate)
          }
}
