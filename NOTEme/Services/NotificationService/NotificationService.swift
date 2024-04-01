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
                    print("\(error.localizedDescription)")
                }
            }
        } else {
            print("Время для таймера уже прошло.")
        }
    }
    func makeDateNotification(dto: DateNotificationDTO) {
        let targetDate = dto.targetDate
        let currentDate = dto.date
        
        if targetDate > currentDate {
            let calendar = Calendar.current
            let components =
            calendar.dateComponents([.year, .month, .day, .hour, .minute],
                                    from: targetDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components,
                                                        repeats: false)
            
            let content = UNMutableNotificationContent()
            content.title = dto.title
            content.body = dto.subtitle ?? "Уведомление запланировано."
            
            let request = UNNotificationRequest(identifier: dto.identifier,
                                                content: content,
                                                trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                }
            }
        } else {
            print("Дата для уведомления уже прошла.")
        }
    }
}


func deleteNotification(for dto: any DTODescription) {
    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [dto.identifier])
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dto.identifier])
    }
