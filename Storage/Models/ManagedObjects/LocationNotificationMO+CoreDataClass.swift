//
//  LocationNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//
//

import Foundation
import CoreData

@objc(LocationNotificationMO)
public class LocationNotificationMO: BaseNotificationMo {
    public func apply(dto: LocationNotificationDTO) {
        self.identifier = dto.identifier
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
        self.longitude = dto.longitude
        self.latitude = dto.latitude
    }
}

extension LocationNotificationMO: MODescription {
    
    public typealias MO = LocationNotificationMO
    
     public func apply(dto: any DTODescription) {
        guard let dto = dto as? LocationNotificationDTO else {
            return
        }
         self.apply(dto: dto)
    }
}
