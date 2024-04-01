//
//  TimerNotificationVM.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage
import CoreData

protocol TimerNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol TimerNotificationStorageProtocol {
    func createTimerNotification(dto: TimerNotificationDTO)
}

protocol TimerNotificationServiceUseCase {
    func makeTimerNotification(dto: TimerNotificationDTO)
}

final class TimerNotificationVM: TimerNotificationViewModelProtocol {
    
    private enum L10n {
        static let errorHandler: String =
        "createDate_errorHandler".localized
    }
    
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    private var storage: TimerNotificationStorageProtocol
    private let notificationService: TimerNotificationServiceUseCase
    
    var timerString: String?
    var title: String? {
        didSet { checkValidation() }
    }
    var comment: String?

    var catchTitleError: ((String?) -> Void)?
    var catchTimerError: ((String?) -> Void)?
   
    private(set) var endTime: Date?
    private var errorHandler: ((String?) -> Void)?
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorageProtocol,
         notificationService: TimerNotificationServiceUseCase) {
        self.coordinator = coordinator
        self.storage = storage
        self.notificationService = notificationService
        
    }
    
    @discardableResult
    private  func checkValidation() -> Bool {
        let titleValid = isValid(title)
        return titleValid 
    }
    
    private  func isValid(_ value: Any?) -> Bool {
        if let title = value as? String, !title.isEmpty {
            return true
        } else if value is Date {
            return true
        } else {
            return false
        }
    }
    
    func update() {
        guard let timerString = timerString,
              let timerDuration = date(from: timerString),
              let timeZone = TimeZone(abbreviation: "UTC")
        else { return }
        
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], 
                                                     from: timerDuration)
        let hoursInSeconds = (timeComponents.hour ?? 0) * 3600
            let minutesInSeconds = (timeComponents.minute ?? 0) * 60
            let seconds = timeComponents.second ?? 0
            let totalSeconds = hoursInSeconds + minutesInSeconds + seconds
            
            endTime = calendar.date(byAdding: .second,
                                    value: totalSeconds,
                                    to: Date())
    }

    
    func createDidTap() {
        guard checkValidation() else {
            errorHandler?(L10n.errorHandler)
            return
        }
        
        update()
        
        guard let title, let endTime else { return }
        
        let dto = TimerNotificationDTO(date: Date(),
                                       identifier: UUID().uuidString,
                                       title: title,
                                       subtitle: comment,
                                       targetTime: endTime)
        storage.createTimerNotification(dto: dto)
        notificationService.makeTimerNotification(dto: dto)
        coordinator?.finish()
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    func string(from date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: string)
    }
    
}



