//
//  PopoverCoordinator.swift
//  NOTEme
//
//  Created by Christina on 8.02.24.
//

import UIKit

final class PopoverCoordinator: Coordinator{
    
    private let container: Container
    private var rootVC: UIViewController?
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let popover = PopoverAssembler.make(coordinator: self)
        rootVC = popover
        return rootVC!
    }
}

extension PopoverCoordinator: PopoverCoordinatorProtocol {
    func openCreateDate() {
        let coordinator = DateNotificationCoordinator(container: Container())
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            self?.finish()
        }
        let vc = coordinator.start()
        rootVC?.present(vc, animated: true)
    }
    
    func openCreateTimer() {
            let coordinator = TimerNotificationCoordinator(container: Container())
            children.append(coordinator)
            
            coordinator.onDidFinish = { [weak self] coordinator in
                self?.children.removeAll { coordinator == $0 }
                self?.finish()
            }
            let vc = coordinator.start()
            rootVC?.present(vc, animated: true)
        }
    }

