//
//  AlertService.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit

final class AlertService {
    
    typealias AlertActionHandler = () -> Void
    
    private let windowManager: WindowManager
    
    init(container: Container) {
        self.windowManager = container.resolve()
    }
    
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
        let window = windowManager.get(type: .alert)
        window.rootViewController = UIViewController()
        windowManager.show(type: .alert)
        window.rootViewController?.present(alertVC, animated: true)
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
        // Add shadow to alert
        alertVC.addShadow()
        
        if let cancelTitle {
            let action = UIAlertAction(title: cancelTitle,
                                       style: .cancel) { [weak self] _ in
                cancelHandler?()
                self?.windowManager.hideAndRemove(type: .alert)
            }
            alertVC.addAction(action)
        }
        if let okTitle {
            let action = UIAlertAction(title: okTitle,
                                       style: .default) { [weak self] _ in
                okHandler?()
                self?.windowManager.hideAndRemove(type: .alert)
            }
            alertVC.addAction(action)
        }
        if let destructiveTitle {
            let action = UIAlertAction(title: destructiveTitle, 
                                       style: .destructive) { [weak self] _ in
                destructiveHandler?()
                self?.windowManager.hideAndRemove(type: .alert)
            }
            alertVC.addAction(action)
        }
        return alertVC
       
    }
}

extension UIAlertController {
    
//    func show() {
//        let alertService = AlertService.current
//        
//        alertService.buildWindow()
//        
//        alertService.window?.makeKeyAndVisible()
//        alertService.window?.rootViewController?.present(self, animated: true)
//    }

}
