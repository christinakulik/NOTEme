//
//  TimerNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//
//

import Foundation
import CoreData

@objc(TimerNotificationMO)
public class TimerNotificationMO: BaseNotificationMo, MODescription {
    
    public typealias DTO = TimerNotificationDTO
    
    public func apply(dto: DTO) {
        self.identifier = dto.identifier
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
        self.targetTime = dto.targetTime
    }
}

