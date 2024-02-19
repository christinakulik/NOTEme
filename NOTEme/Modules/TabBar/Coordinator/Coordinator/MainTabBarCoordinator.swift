//
//  MainTabBarCoordinator.swift
//  NOTEme
//
//  Created by Christina on 18.12.23.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    private let popoverDelegate = PopoverDelegate()
    private let container: Container
   var currentPopover: UIViewController?
    private var tabBarController: UITabBarController?
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let tabBar = MainTabBarAssembler.make(coordinator: self)
        tabBar.viewControllers = [makeHomeModule(), makeProfileModule()]
        tabBarController = tabBar
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
    func showPopover() {
        let coordinator = PopoverCoordinator(container: container)
        children.append(coordinator)
        
        let popover = coordinator.start()
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            popover.dismiss(animated: true)
        }
        popover.modalPresentationStyle = .popover
        popover.preferredContentSize = CGSize(width: 180, height: 120)
        
        if popover.popoverPresentationController?.delegate == nil {
                  popover.popoverPresentationController?.delegate = popoverDelegate
              }
        currentPopover = popover
        if let popoverController = popover.popoverPresentationController {
            popoverController.sourceView = tabBarController?.view
            popoverController.sourceRect = CGRect(
                x: (tabBarController?.view.bounds.width)! - 288,
                y: (tabBarController?.view.bounds.height ?? 0) - 80,
                width: 200,
                height: 200)
            tabBarController?.present(popover, animated: true)
        }
            
    }
}


final class PopoverDelegate: NSObject, UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController)
    -> UIModalPresentationStyle {
        return .none
    }
}
