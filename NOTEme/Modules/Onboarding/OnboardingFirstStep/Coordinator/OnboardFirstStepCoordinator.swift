//
//  OnboardFirstStepCoordinator.swift
//  NOTEme
//
//  Created by Christina on 28.11.23.
//

import UIKit

final class OnboardFirstStepCoordinator: Coordinator {
    
    private var rootNC: UINavigationController?
    
    override func start() -> UIViewController {
        let vc = OnboardFirstStepAssembler.make(self)
        let nc = UINavigationController(rootViewController: vc)
        self.rootNC = nc
        return nc
    }
}

extension OnboardFirstStepCoordinator: OnboardFirstStepCoordinatorProtocol {
    func openNextStep() {
        let coordinator = OnboardSecondStepCoordinator()
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            self?.finish()
        }
        coordinator.onDismissedByUser = { [weak self] coordinator in
            self?.children.removeAll() { coordinator == $0 }
            
        }
        let vc = coordinator.start()
        rootNC?.pushViewController(vc, animated: true)
        
    }
}
