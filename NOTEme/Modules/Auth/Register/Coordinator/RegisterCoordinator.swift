//
//  RegisterCoordinator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    
    override func start() -> UIViewController {
        return RegisterAssembler.make(container: container,
                                      coordinator: self)
    }
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {}
