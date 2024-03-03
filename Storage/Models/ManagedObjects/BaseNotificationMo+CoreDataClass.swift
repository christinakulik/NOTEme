//
//  BaseNotificationMo+CoreDataClass.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//
//

import Foundation
import CoreData

@objc(BaseNotificationMo)
public class BaseNotificationMo: NSManagedObject, MODescription {
    public func toDTO() -> (any DTODescription)? {
        return BaseNotificationDTO.fromMO(self)
    }
    
    public func apply(dto: any DTODescription) {
        self.identifier = dto.identifier
        self.date = dto.date
        self.completedDate = dto.completedDate
        self.title = dto.title
        self.subtitle = dto.subtitle
    }
}

