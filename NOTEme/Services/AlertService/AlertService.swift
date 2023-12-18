//
//  AlertService.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit

final class AlertService {
    
    typealias AlertActionHandler = () -> Void
    
    static var current: AlertService = .init()
    
    fileprivate var window: UIWindow?
    
    func showAlert(title: String?,
                   message: String?,
                   cancelTitle: String? = nil,
                   cancelHandler: AlertActionHandler? = nil,
                   okTitle: String? = nil,
                   okHandler: AlertActionHandler? = nil) {
        // build
        let alertVC = buildAlert(title: title,
                                 message: message, 
                                 cancelTitle: cancelTitle,
                                 cancelHandler: cancelHandler,
                                 okTitle: okTitle,
                                 okHandler: okHandler)
        buildWindow()
        //show
        window?.rootViewController!.present(alertVC, animated: true)
        window?.makeKeyAndVisible()
        
    }
    
    fileprivate func buildWindow() {
        guard
            let scene = AppCoordinator.windowScene
        else { return }
        
        self.window = UIWindow(windowScene: scene)
        self.window?.windowLevel = .alert
        self.window?.rootViewController = UIViewController()
    }
    
    func removeWindow() {
        self.window?.resignKey()
        self.window = nil
    }
    
    private func buildAlert(title: String?,
                            message: String?,
                            cancelTitle: String? = nil,
                            cancelHandler: AlertActionHandler? = nil,
                            okTitle: String? = nil,
                            okHandler: AlertActionHandler? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        if let cancelTitle {
            let action = UIAlertAction(title: cancelTitle,
                                       style: .cancel) { [weak self] _ in
                cancelHandler?()
                self?.removeWindow()
            }
            alertVC.addAction(action)
        }
        if let okTitle {
            let action = UIAlertAction(title: okTitle,
                                       style: .default) { [weak self] _ in
                okHandler?()
                self?.removeWindow()
            }
            alertVC.addAction(action)
        }
        return alertVC
    }
}

extension UIAlertController {
    
    func show() {
        let alertService = AlertService.current
        
        alertService.buildWindow()
        
        alertService.window?.makeKeyAndVisible()
        alertService.window?.rootViewController?.present(self, animated: true)
    }
}
