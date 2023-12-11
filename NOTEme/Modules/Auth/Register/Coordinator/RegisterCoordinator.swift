//
//  RegisterCoordinator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        return RegisterAssembler.make(coordinator: self)
    }    
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {
    func showAlert(_ alert: UIAlertController) {
        rootVC?.present(alert, animated: true)
        
    }
}
