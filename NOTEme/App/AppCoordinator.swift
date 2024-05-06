//
//  AppCoordinator.swift
//  NOTEme
//
//  Created by Christina on 21.11.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let container: Container
    private let windowManager: WindowManager
    
    
    init(container: Container) {
        self.container = container
        self.windowManager = container.resolve()
    }

    func startApp() {
        // TODO: FIXME
        //        ParametersHelper.set(.authenticated, value: false)
        //        ParametersHelper.set(.onboarded, value: false)
        if ParametersHelper.get(.authenticated) {
            if ParametersHelper.get(.onboarded) {
                openMainModule()
            } else {
                openOnboardingModule()
            }
        } else {
            openAuthModule()
        }
    }
    
    private func openAuthModule() {
        let coordinator = LoginCoordinator(container: container)
        children.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { $0 == coordinator }
            self?.startApp()
        }
        let vc = coordinator.start()

        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openOnboardingModule() {
    let coordinator = OnboardFirstStepCoordinator()
        children.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { $0 == coordinator }
            self?.startApp()
        }
        let vc = coordinator.start()
         
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openMainModule() {
        
        let coordinator = MainTabBarCoordinator(container: container)
            children.append(coordinator)
            coordinator.onDidFinish = { [weak self] coordinator in
                self?.children.removeAll { $0 == coordinator }
                self?.startApp()
            }
            let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
}
    
    

