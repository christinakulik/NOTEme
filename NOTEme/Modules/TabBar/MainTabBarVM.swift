//
//  MainTabBarVM.swift
//  NOTEme
//
//  Created by Christina on 8.02.24.
//

import UIKit


protocol MainTabBarCoordinatorProtocol: AnyObject {
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate)
    func openDateNotification()
    func openTimerNotification()
    func openLicationNotification()
}

final class MainTabBarVM: MainTabBarViewModelProtocol {
    
    private weak var coordinator: MainTabBarCoordinatorProtocol?
    
    
    init(coordinator: MainTabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
    
    func addDidTap(sender: UIView) {
        coordinator?.showMenu(sender: sender, delegate: self)
    }
    
}

extension MainTabBarVM: MenuPopoverDelegate {
    func didSelect(action: MenuPopoverVC.Action) {
        switch action {
        case .calendar:
            coordinator?.openDateNotification()
        case .timer:
            coordinator?.openTimerNotification()
        case .location:
            coordinator?.openLicationNotification()
        default: break
        }
    }
}
