//
//  CreateDateVM.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage

protocol CreateDateStorageProtocol {
    func create(dto: DateNotificationDTO)
}

protocol CreateDateCoordinatorProtocol: AnyObject {
    func finish()
}

final class CreateDateVM: CreateDateViewModelProtocol {
    
    private weak var coordinator: CreateDateCoordinatorProtocol?
    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    var title: String? {
        didSet { checkValidation() }
    }
    var date: Date? {
        didSet { checkValidation() }
    }
    var comment: String?
    
    init(coordinator: CreateDateCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func createDidTap() {
        guard
            checkValidation() else { return }
        guard
            let title, let date else { return }
        let dto = DateNotificationDTO(date: Date(),
                                      identifier: UUID().uuidString,
                                      title: title,
                                      subtitle: comment,
                                      targetDate: date)
        // TODO UseCase
        let service = DateNotificationStorage()
        service.create(dto: dto)
        print(service.fetch())
        coordinator?.finish()
    }
    
    func string(from date: Date?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        guard
            let date else { return nil }
        return formatter.string(from: date)
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    @discardableResult
    func checkValidation() -> Bool {
        catchTitleError?(isValid(title) ? nil : "")
        catchDateError?(isValid(date) ? nil : "")
        return isValid(title) && isValid(date)
    }
    
    func isValid(_ title: String?) -> Bool {
        if let title {
            return (!title.isEmpty) && (title != "")
        } else {
            return false
        }
    }
    func isValid(_ date: Date?) -> Bool {
        date != nil
    }
    
}
