//
//  DateNotificationVM.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage

protocol DateNotificationStorageProtocol {
    func createDateNotification(dto: DateNotificationDTO)
}

protocol DateNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

final class DateNotificationVM: DateNotificationViewModelProtocol {
    
    private enum L10n {
        static let errorHandler: String =
        "createDate_errorHandler".localized
    }
    
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    private var storage: DateNotificationStorageProtocol
    
    private var errorHandler: ((String?) -> Void)?
    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    var title: String? {
        didSet { checkValidation() }
    }
    var date: Date? {
        didSet { checkValidation() }
    }
    var comment: String?
    
    // MARK: - Initializer
    init(coordinator: DateNotificationCoordinatorProtocol,
         storage: DateNotificationStorageProtocol) {
        self.coordinator = coordinator
        self.storage = storage
    }
    
    // MARK: - Public Methods
    func createDidTap() {
        guard
            checkValidation()
        else { 
            errorHandler?(L10n.errorHandler)
            return }
        guard
            let title, let date else { return }
        let dto = DateNotificationDTO(date: Date(),
                                      identifier: UUID().uuidString,
                                      title: title,
                                      subtitle: comment,
                                      targetDate: date)
        storage.createDateNotification(dto: dto)
        coordinator?.finish()
    }
    
    func string(from date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: string)
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    @discardableResult
    func checkValidation() -> Bool {
        let titleValid = isValid(title)
        let dateValid = isValid(date)
        return titleValid && dateValid
    }
    
    // MARK: - Private Methods
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
