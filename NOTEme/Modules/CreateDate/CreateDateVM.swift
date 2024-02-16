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
    
    init(coordinator: CreateDateCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func createDidTap() {
        guard
            checkValidation()
        else { 
            errorHandler?("Please fill in all required fields")
            return }
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
    
    func string(from date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
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
    
    
    func isValid(_ value: Any?) -> Bool {
        if let title = value as? String, !title.isEmpty {
            return true
        } else if let date = value as? Date {
            return true
        } else {
            return false
        }
    }
}
