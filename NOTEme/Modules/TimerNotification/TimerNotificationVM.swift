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
    
    private(set) var endTime: Date? {
        didSet { checkValidation() }
    }
    
    private var errorHandler: ((String?) -> Void)?
    var catchTitleError: ((String?) -> Void)?
    var catchTimerError: ((String?) -> Void)?
    
    
    var title: String? {
        didSet { checkValidation() }
    }
    var timer: Date?
    var comment: String?
    
    init(coordinator: TimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorageProtocol) {
        self.coordinator = coordinator
        self.storage = storage
        
    }
    
    private func update () {
        guard  let timerInterval = timer?.timeIntervalSinceReferenceDate
        else { return  }
        let now = Date ()
        endTime = Calendar.current.date (byAdding: .second,
                                         value: Int (timerInterval),
                                         to: now)!
    }
    
    func createDidTap() {
        guard
            checkValidation()
        else {
            errorHandler?(L10n.errorHandler)
            return }
        guard
            let title, let endTime else { return }
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
        return dateFormatter.date(from: string)
    }
    
    @discardableResult
    func checkValidation() -> Bool {
        let titleValid = isValid(title)
        let dateValid = isValid(endTime)
        return titleValid && dateValid
    }
    
    func isValid(_ value: Any?) -> Bool {
        if let title = value as? String, !title.isEmpty {
            return true
        } else if value is Date {
            return true
        } else {
            return false
        }
    }
    
}



