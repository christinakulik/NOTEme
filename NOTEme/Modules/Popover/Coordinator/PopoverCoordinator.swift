//
//  PopoverCoordinator.swift
//  NOTEme
//
//  Created by Christina on 8.02.24.
//

import UIKit

final class PopoverCoordinator: Coordinator{
    
    private let container: Container
    private var viewController: UIViewController!
    private var rootNC: UINavigationController?
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let popover = PopoverAssembler.make(coordinator: self)
        let nc = UINavigationController(rootViewController: popover)
        self.rootNC = nc
        return nc
    }
}

extension PopoverCoordinator: PopoverCoordinatorProtocol {
    func openCreateDate() {
        let coordinator = CreateDateCoordinator(container: Container())
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            self?.finish()
        }
        let vc = coordinator.start()
        rootNC?.pushViewController(vc, animated: true)
    }
    
    func openCreateTimer() {
            let coordinator = CreateTimerCoordinator(container: Container())
            children.append(coordinator)
            
            coordinator.onDidFinish = { [weak self] coordinator in
                self?.children.removeAll { coordinator == $0 }
                self?.finish()
            }
            let vc = coordinator.start()
            rootNC?.pushViewController(vc, animated: true)
        }
    }

