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

    public override func toDTO() -> (any DTODescription)? {
        return LocationNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
       guard let locationDTO = dto as? LocationNotificationDTO
        else {
           print("[MODTO]", "\(Self.self)apply failed: dto is type of \(type(of: dto))")
           return
       }
        
        super.apply(dto: locationDTO)
        self.longitude = locationDTO.longitude
        self.latitude = locationDTO.latitude
    }
}



