//
//  MainTabBarVM.swift
//  NOTEme
//
//  Created by Christina on 8.02.24.
//

import Foundation


protocol MainTabBarCoordinatorProtocol: AnyObject {
    func showPopover()
}

final class MainTabBarVM: MainTabBarViewModelProtocol {
    
    private weak var coordinator: MainTabBarCoordinatorProtocol?
    
    
    init(coordinator: MainTabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func addDidTap() {
        coordinator?.showPopover()
    }
    
}
