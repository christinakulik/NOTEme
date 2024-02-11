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
public class TimerNotificationMO: BaseNotificationMo {
    public func apply(dto: TimerNotificationDTO) {
        self.identifier = dto.identifier
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
        self.duration = dto.duration
    }
}

extension TimerNotificationMO: MODescription {
  
    public typealias MO = TimerNotificationMO
    
    public func apply(dto: any DTODescription) {
        guard let dto = dto as? TimerNotificationDTO else {
            return
        }
        self.apply(dto: dto)
    }
}
