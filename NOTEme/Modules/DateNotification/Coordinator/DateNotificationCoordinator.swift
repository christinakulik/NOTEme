//
//  CreateDateCoordinator.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit

final class DateNotificationCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        return DateNotificationAssembler.make(container: container,
                                   coordinator: self)
    }
}

extension DateNotificationCoordinator: DateNotificationCoordinatorProtocol {}
