//
//  TimerNotificationDTO.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import Foundation

public struct TimerNotificationDTO: DTODescription {
    public typealias DTO = Self
    public typealias MO = TimerNotificationMO
    
    public var date: Date
    public var identifier: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var duration: Int16
    
    public init(date: Date,
                identifier: String,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                duration: Int16) {
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.duration = duration
    }
    
    public init?(mo: TimerNotificationMO) {
        guard
            let identifier = mo.identifier,
            let title = mo.title,
            let date = mo.date
        else { return nil }
        
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = mo.subtitle
        self.completedDate = mo.completedDate
        self.duration = mo.duration
    }
}
