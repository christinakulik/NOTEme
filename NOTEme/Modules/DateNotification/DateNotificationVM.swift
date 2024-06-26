//
//  DateNotificationVM.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage

protocol DateNotificationStorageProtocol {
    func updateOrCreate(dto: any DTODescription,
                        completion: ((Bool) -> Void)?)
}

protocol DateNotificationServiceUseCase {
    func makeDateNotification(dto: DateNotificationDTO)
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
    private var dtoToEdit: DateNotificationDTO?
    private var notificationCenter: DateNotificationServiceUseCase
    
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
         storage: DateNotificationStorageProtocol,
         notificationCenter: DateNotificationServiceUseCase,
         dtoToEdit: DateNotificationDTO? = nil) {
        self.coordinator = coordinator
        self.storage = storage
        self.notificationCenter = notificationCenter
        self.dtoToEdit = dtoToEdit
        
        loadDTOToEdit()
    }

    
    // MARK: - Public Methods
    func loadDTOToEdit() {
            guard let dto = dtoToEdit else { return }
            title = dto.title
            date = dto.targetDate
            comment = dto.subtitle
        }
    
    func createDidTap() {
        guard checkValidation() else {
            errorHandler?(L10n.errorHandler)
            return
        }
        guard let title, let date else { return }
        
        let dto: DateNotificationDTO
        if let dtoToEdit = dtoToEdit {
            // Update the existing DTO
            dto = DateNotificationDTO(date: dtoToEdit.date,
                                      identifier: dtoToEdit.identifier,
                                      title: title,
                                      subtitle: comment,
                                      targetDate: date)
            storage.updateOrCreate(dto: dto, completion: nil)
        } else {
            // Create a new DTO
            dto = DateNotificationDTO(date: Date(),
                                      identifier: UUID().uuidString,
                                      title: title,
                                      subtitle: comment,
                                      targetDate: date)
            storage.updateOrCreate(dto: dto, completion: nil)
        }
        notificationCenter.makeDateNotification(dto: dto)
        
        let backupService = FirebaseBackupService()
        backupService.backup(dto: dto)
        
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
