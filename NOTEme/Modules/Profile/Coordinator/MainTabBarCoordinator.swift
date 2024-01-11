//
//  MainTabBarCoordinator.swift
//  NOTEme
//
//  Created by Christina on 18.12.23.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        let tabBar = MainTabBarAssembler.make()
        tabBar.viewControllers = [makeHomeModule(), makeProfileModule()]
        
        return tabBar
    }
    
    private func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator()
        children.append(coordinator)
        
        return coordinator.start()
    }
   
    private func makeProfileModule() -> UIViewController {
        let coordinator = ProfileCoordinator()
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            self?.finish()
        }
        children.append(coordinator)
        
        return coordinator.start()
    }
    
}


