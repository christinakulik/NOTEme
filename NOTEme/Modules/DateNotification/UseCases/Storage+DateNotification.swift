//
//  Storage+DateNotification.swift
//  NOTEme
//
//  Created by Christina on 15.02.24.
//

import Foundation
import Storage


extension DateNotificationStorage: DateNotificationStorageProtocol {
    func createDateNotification(dto: Storage.DateNotificationDTO) {
        create(dto: dto)
    }
    
    func updateDateNotification(dto: Storage.DateNotificationDTO) {
        update(dto: dto)
    }
}
