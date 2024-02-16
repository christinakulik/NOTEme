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
    private(set) var endTime: Date?
    
    var title: String?
    var duration: TimeInterval? {
        didSet {
            updateEndTime()
        }
    }
   var comment: String?
    
    init(coordinator: CreateTimerCoordinatorProtocol) {
        self.coordinator = coordinator
        
        updateEndTime()
    }
    
    func createDidTap() {
        guard
            let title, let endTime else { return }
        let dto = DateNotificationDTO(date: Date(),
                                      identifier: UUID().uuidString,
                                      title: title,
                                      subtitle: comment,
                                      targetDate: endTime)
        // TODO UseCase
        let service = DateNotificationStorage()
        service.create(dto: dto)
        print(service.fetch())
        coordinator?.finish()
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    func string(from date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh.mm.ss"
        return formatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh.mm.ss"
        return dateFormatter.date(from: string)
    }
    
    private func updateEndTime() {
        endTime = duration.map { Date().addingTimeInterval(-$0) }
    }
    
}



