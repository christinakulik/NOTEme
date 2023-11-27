//
//  RegisterCoordinator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return RegisterAssembler.make(coordinator: self)
    }    
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {}
