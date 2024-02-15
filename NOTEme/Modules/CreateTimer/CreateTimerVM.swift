//
//  CreateTimerVM.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage
import CoreData

protocol CreateTimerCoordinatorProtocol: AnyObject {
    func finish()
}

final class CreateTimerVM: CreateTimerViewModelProtocol {
    
    private weak var coordinator: CreateTimerCoordinatorProtocol?
    
    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    var title: String? {
        didSet { checkValidation() }
    }
    var date: Date? {
        didSet { checkValidation() }
    }
    var comment: String?
    
    init(coordinator: CreateTimerCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func createDidTap() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH-mm-ss"
        let testDate = "06-45-10"
        guard let targetDate = formatter.date(from: testDate) else { return }
        
        let testTitle = "Meeting"
        let testSubTitle = "Meeting in the park"
        
        let timeInterval = targetDate.timeIntervalSince(Date()+100)
        let targetDateTime = Date().addingTimeInterval(timeInterval)
        
        
        let dto = DateNotificationDTO(date: Date(),
                                      identifier: UUID().uuidString,
                                      title: testTitle,
                                      subtitle: testSubTitle,
                                      targetDate: targetDateTime)
        // TODO UseCase
        let service = DateNotificationStorage()
        service.create(dto: dto)
        print(service.fetch())
        coordinator?.finish()
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



