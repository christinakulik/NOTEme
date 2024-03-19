//
//  NotificationService.swift
//  NOTEme
//
//  Created by Christina on 13.03.24.
//

import Foundation
import CoreLocation
import UserNotifications
import Storage

final class NotificationService {
    
     func makeLocationNotification(circleRegion: CLCircularRegion,
                                  dto: LocationNotificationDTO) {
        circleRegion.notifyOnEntry = true
        circleRegion.notifyOnExit = false
        let triger = UNLocationNotificationTrigger(region: circleRegion,
                                                   repeats: false)
        
        let content = UNMutableNotificationContent()
         content.title = dto.title
         
         if let subtitle = dto.subtitle {
             content.body = subtitle
         }
        
         let request = UNNotificationRequest(identifier: dto.identifier,
                                            content: content,
                                            trigger: triger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func makeTimerNotification(dto: TimerNotificationDTO) {
        let currentTime = Date()
        let timerInterval = dto.targetTime.timeIntervalSince(currentTime)
        
        if timerInterval > 0 {
            let trigger = 
            UNTimeIntervalNotificationTrigger(timeInterval: timerInterval,
                                              repeats: false)
            let content = UNMutableNotificationContent()
            content.title = dto.title
            content.body = dto.subtitle ?? "Таймер завершен."
            
            let request = UNNotificationRequest(identifier: dto.identifier, 
                                                content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
                }
            }
        } else {
            print("Время для таймера уже прошло.")
        }
    }

}
//        UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: <#T##Bool#>)
//        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: <#T##[String]#>)
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: <#T##[String]#>)
