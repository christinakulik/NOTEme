//
//  CreateDateVM.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage
import CoreData

protocol CreateDateCoordinatorProtocol: AnyObject {
    func finish()
}

final class CreateDateVM: CreateDateViewModelProtocol {

    private weak var coordinator: CreateDateCoordinatorProtocol?
    
    
    init(coordinator: CreateDateCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func createDidTap(title: String?, comment: String?, date: String?) {
        // TODO: FIXME
        let dto = DateNotificationDTO(date: .init(),
                                      identifier: UUID().uuidString,
                                      title: title ?? "",
                                      targetDate: .init() + 1000)
        let service = DateNotificationStorage()
        service.create(dto: dto)
        coordinator?.finish()
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
}
