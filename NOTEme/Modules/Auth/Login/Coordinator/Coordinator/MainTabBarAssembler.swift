//
//  MainTabBarAssembler.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit

final class MainTabBarAssembler {
    
    init() {}
    
    static func make() -> UITabBarController {
        let tabbar = MainTabBarVC()
        
//        let homeVC = UIViewController()
//        homeVC.view.backgroundColor = .cyan
//        
//        let profileVC = UIViewController()
//        profileVC.view.backgroundColor = .blue
//        
//        tabbar.viewControllers = [homeVC, profileVC]
        
        return tabbar
    }
}
