//
//  AppCoordinator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    static var windowScene: UIWindowScene?
    
    private var window: UIWindow
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        Self.windowScene = scene
    }
   
    func startApp() {
// TODO: FIXME
//        ParametersHelper.set(.authenticated, value: false)
//        ParametersHelper.set(.onboarded, value: false)

//        openOnboardingModule()
        
//        if ParametersHelper.get(.onboarded) {
            openMainModule()
//        } else if ParametersHelper.get(.authenticated) {
//            openOnboardingModule()
//        } else {
//            openAuthModule()
//        }
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
    
    private func openMainModule() {
//        let tabbar = UITabBarController()
//        tabbar.viewControllers = [UIViewController(), UIViewController()]
//        window.rootViewController = tabbar
        
        let coordinator = MainTabBarCoordinator()
            children.append(coordinator)
            coordinator.onDidFinish = { [weak self] coordinator in
                self?.children.removeAll { $0 == coordinator }
                self?.startApp()
            }
            let vc = coordinator.start()
            
            window.rootViewController = vc
            window.makeKeyAndVisible()
        
//        let homeVC =  UIViewController()
//        let profileVC = UIViewController()
    }
}
    
    

