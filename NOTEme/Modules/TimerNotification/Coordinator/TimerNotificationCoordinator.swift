//
//  TimerNotificationCoordinator.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit

final class TimerNotificationCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        return TimerNotificationAssembler.make(container: container,
                                   coordinator: self)
    }
}

extension TimerNotificationCoordinator: TimerNotificationCoordinatorProtocol {}
