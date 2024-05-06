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
    
    public override func toDTO() -> (any DTODescription)? {
        return TimerNotificationDTO.fromMO(self)
    }
    public override func apply(dto: any DTODescription) {
        guard let timerDTO = dto as? TimerNotificationDTO
        else {
            print("[MODTO]", "\(Self.self)apply failed: dto is type of \(type(of: dto))")
            return
        }
        
        super.apply(dto: timerDTO)
        self.targetTime = timerDTO.targetTime
    }
}

