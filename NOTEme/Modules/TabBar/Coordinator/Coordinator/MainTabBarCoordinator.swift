//
//  MainTabBarCoordinator.swift
//  NOTEme
//
//  Created by Christina on 18.12.23.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {

    private let container: Container
    private var rootVC: UIViewController?
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let tabBar = MainTabBarAssembler.make(coordinator: self)
        tabBar.viewControllers = [makeHomeModule(), makeProfileModule()]
        rootVC = tabBar
        return tabBar
    }
    
    private func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator()
        children.append(coordinator)
        
        return coordinator.start()
    }
   
    private func makeProfileModule() -> UIViewController {
        let coordinator = ProfileCoordinator(container: container)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            self?.finish()
        }
        children.append(coordinator)
        
        return coordinator.start()
    }
    
}

extension MainTabBarCoordinator: MainTabBarCoordinatorProtocol {
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate) {
        let menu = MenuPopoverBuilder.buildAddMenu(delegate: delegate,
                                                   sourceView: sender)
        rootVC?.present(menu, animated: true)
    }
    
    
    func openDateNotification() {
        let coordinator = DateNotificationCoordinator(container: Container())
        children.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
       
        rootVC?.present(vc, animated: true)
    }
    
    func openTimerNotification() {
        let coordinator = TimerNotificationCoordinator(container: Container())
        children.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        rootVC?.present(vc, animated: true)
    }
    
    func openLocationNotification() {
        let coordinator = LocationNotificationCoordinator(container: Container(),
                                                          dto: nil)
        children.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        rootVC?.present(vc, animated: true)
    }
}


