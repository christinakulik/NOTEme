//
//  MainTabBarAssembler.swift
//  NOTEme
//
//  Created by Christina on 18.12.23.
//

import UIKit

final class MainTabBarAssembler {
    
    private init() {}
    
    static func make() -> UITabBarController {
        let tabBar = MainTabBarVC()
        
        return tabBar
    }
}
