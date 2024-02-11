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
    
    
    init(coordinator: CreateTimerCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func createDidTap(title: String?, comment: String?, date: String?) {
        // TODO: FIXME
        let dto = TimerNotificationDTO(date: .init(),
                                      identifier: UUID().uuidString,
                                       title: title ?? "", duration: <#Int16#>)
        let service = TimerNotificationStorage()
        service.create(dto: dto)
        coordinator?.finish()
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
}

