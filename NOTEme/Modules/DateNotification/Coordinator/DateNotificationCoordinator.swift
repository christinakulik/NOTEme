//
//  CreateDateCoordinator.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage

final class DateNotificationCoordinator: Coordinator {
    
    private let container: Container
    private var dtoToEdit: DateNotificationDTO?
    
   
    
    init(container: Container, dtoToEdit: DateNotificationDTO? = nil) {
        self.container = container
        self.dtoToEdit = dtoToEdit
    }
    
    override func start() -> UIViewController {
        return DateNotificationAssembler.make(container: container,
                                              coordinator: self,
                                              dtoToEdit: dtoToEdit)
    }
}

extension DateNotificationCoordinator: DateNotificationCoordinatorProtocol {}
