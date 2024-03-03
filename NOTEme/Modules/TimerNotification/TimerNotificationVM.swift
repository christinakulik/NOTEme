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

final class TimerNotificationVM: TimerNotificationViewModelProtocol {
    
    private enum L10n {
        static let errorHandler: String =
        "createDate_errorHandler".localized
    }
    
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    private var storage: TimerNotificationStorageProtocol
    
    private(set) var endTime: Date?
    
    private var errorHandler: ((String?) -> Void)?
    var catchTitleError: ((String?) -> Void)?
    var catchTimerError: ((String?) -> Void)?
    
    
    var title: String? {
        didSet { checkValidation() }
    }
    var timer: Date? {
        didSet { checkValidation() }
    }
    var comment: String?
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorageProtocol) {
        self.coordinator = coordinator
        self.storage = storage
        
    }
    
    @discardableResult
    private  func checkValidation() -> Bool {
        let titleValid = isValid(title)
        let dateValid = isValid(timer)
        return titleValid && dateValid
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
    
    private func update() {
        guard let timerInterval = timer?.timeIntervalSinceReferenceDate else { return }
        
        let calendar = Calendar.current
        let now = Date()
        
        if let newDate = calendar.date(byAdding: .second, 
                                       value: Int(timerInterval),
                                       to: now) {
        endTime = newDate
        }
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



