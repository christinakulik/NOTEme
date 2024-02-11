//
//  CreateTimerCoordinator.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit

final class CreateTimerCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        return CreateTimerAssembler.make(container: container,
                                   coordinator: self)
    }
}

extension CreateTimerCoordinator: CreateTimerCoordinatorProtocol {}
