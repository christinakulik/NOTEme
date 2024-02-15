//
//  DateNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//
//

import Foundation
import CoreData

@objc(DateNotificationMO)
public class DateNotificationMO: BaseNotificationMo, MODescription {
    public typealias DTO = DateNotificationDTO

    public func apply(dto: DTO) {
        self.identifier = dto.identifier
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
        self.targetDate = dto.targetDate
    }
}



