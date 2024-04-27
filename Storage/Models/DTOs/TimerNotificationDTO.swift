//
//  TimerNotificationDTO.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import Foundation
import CoreData

public struct TimerNotificationDTO: DTODescription {
    public typealias DTO = Self
    public typealias MO = TimerNotificationMO
    
    public var date: Date
    public var identifier: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var targetTime: Date
  
    public init(date: Date,
                identifier: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                targetTime: Date) {
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.targetTime = targetTime
    }
    
    public static func fromMO(_ mo: TimerNotificationMO) -> TimerNotificationDTO? {
        guard
            let identifier = mo.identifier,
            let title = mo.title,
            let date = mo.date,
            let targetTime = mo.targetTime
        else { return nil }
       
        return TimerNotificationDTO(date: date, 
                                    identifier: identifier,
                                    title: title,
                                    subtitle: mo.subtitle,
                                    completedDate: mo.completedDate,
                                    targetTime: targetTime)
    }
    
    public func createMO(context: NSManagedObjectContext) -> TimerNotificationMO? {
        let mo = TimerNotificationMO(context: context)
        mo.apply(dto: self)
        return mo
    }
}
