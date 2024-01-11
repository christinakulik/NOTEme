//
//  LoginCoordinator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        let vc = LoginAssembler.make(coordinator: self)
        rootVC = vc
        return vc
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    
    func openRegisterModule() {
        let coordinator = RegisterCoordinator()
        children.append(coordinator)
        let vc = coordinator.start()
        coordinator.onDidFinish = {  [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
                vc.dismiss(animated: true)
            }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
            rootVC?.present(vc, animated: true)
        }
        
        func openResetModule() { 
            let coordinator = ResetCoordinator()
            children.append(coordinator)
            let vc = coordinator.start()
            
            coordinator.onDidFinish = { [weak self] coordinator in
                self?.children.removeAll { coordinator == $0 }
                vc.dismiss(animated: true)
            }
            vc.modalPresentationStyle = .fullScreen
                rootVC?.present(vc, animated: true)
        }
    }

