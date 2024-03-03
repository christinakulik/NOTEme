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
public class DateNotificationMO: BaseNotificationMo {
    
    public override func toDTO() -> (any DTODescription)? {
        return DateNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
       guard let dateDTO = dto as? DateNotificationDTO
        else {
           print("[MODTO]", "\(Self.self)apply failed: dto is type of \(type(of: dto))")
           return
       }
        
        super.apply(dto: dateDTO)
        self.targetDate = dateDTO.targetDate
    }
}


