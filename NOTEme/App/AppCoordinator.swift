//
//  AppCoordinator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private var window: UIWindow
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
    }
   
    func startApp() {
        
        if ParametersHelper.get(.authenticated) {
    //            FIXME: - TEST CODE
    //           ParametersHelper.set(.authenticated, value: false)
    //            open onboarding or mainApp
            openOnboardingModule()
        } else {
            openAuthModule()
        }
        
        if ParametersHelper.get(.onboarded) {
            openTMainModule()
        }  else {
            openOnboardingModule()
        }
    }
    
    private func openAuthModule() {
       let coordinator = LoginCoordinator()
        children.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { $0 == coordinator }
            self?.startApp()
        }
        let vc = coordinator.start()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    private func openOnboardingModule() {
    let coordinator = OnboardFirstStepCoordinator()
        children.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { $0 == coordinator }
            self?.startApp()
        }
        let vc = coordinator.start()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    private func openTMainModule() {
        let tabbar = UITabBarController()
        
        let homeVC =  UIViewController()
        let profileVC = UIViewController()

        homeVC.view.backgroundColor = .appYellow
        profileVC.view.backgroundColor = .appGray
        
        homeVC.tabBarItem =
        UITabBarItem(title: "main_screen_home_tabbarItem".localized,
                     image: .Tabbar.home,
                     selectedImage: .Tabbar.homeSelected)
        profileVC.tabBarItem =
        UITabBarItem(title: "main_screen_profile_tabbarItem".localized,
                     image: .Tabbar.profile,
                     selectedImage: .Tabbar.profileSelected)
        
        tabbar.viewControllers = [homeVC, profileVC].map 
        { UINavigationController(rootViewController: $0) }
        
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
    }
}
    
    

