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
                   okHandler: AlertActionHandler? = nil,
                   destructiveTitle: String? = nil,
                   destructiveHandler: AlertActionHandler? = nil) {
        // build
        let alertVC = buildAlert(title: title,
                                 message: message, 
                                 cancelTitle: cancelTitle,
                                 cancelHandler: cancelHandler,
                                 okTitle: okTitle,
                                 okHandler: okHandler,
                                 destructiveTitle: destructiveTitle,
                                 destructiveHandler: destructiveHandler)
        buildWindow()
        //show
        window?.makeKeyAndVisible()
        window?.rootViewController!.present(alertVC, animated: true)
        
        
    }
    
    fileprivate func buildWindow() {
        guard
            let scene = AppCoordinator.windowScene
        else { return }
        
        self.window = UIWindow(windowScene: scene)
        self.window?.windowLevel = .alert
        self.window?.rootViewController = UIViewController()
        
        self.window?.layer.applyShadow()
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
                            okHandler: AlertActionHandler? = nil,
                            destructiveTitle: String? = nil,
                            destructiveHandler: AlertActionHandler? = nil)
    -> UIAlertController {
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
        if let destructiveTitle {
            let action = UIAlertAction(title: destructiveTitle, 
                                       style: .destructive) { [weak self] _ in
                destructiveHandler?()
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
    
    func applyShadow() {
            
            DispatchQueue.main.async {
                self.view.clipsToBounds = false
                self.view.layer.shadowColor = UIColor(red: 0,
                                                      green: 0,
                                                      blue: 0,
                                                      alpha: 0.04).cgColor
                self.view.layer.shadowOpacity = 1
                self.view.layer.shadowOffset = CGSize(width: 0, height: 3)
                self.view.layer.shadowRadius = 9
                self.view.cornerRadius = 14.0
            }
        }
}
