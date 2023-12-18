//
//  MainTabBarCoordinator.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        let tabbar = MainTabBarAssembler.make()
        tabbar.viewControllers = [makeHomeModule(), makeHomeModule()]
        return tabbar
    }
    
    private func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator()
        children.append(coordinator)
        
        return coordinator.start()
    }
}
