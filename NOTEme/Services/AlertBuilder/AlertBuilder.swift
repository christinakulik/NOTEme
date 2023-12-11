//
//  AlertBuilder.swift
//  NOTEme
//
//  Created by Christina on 5.12.23.
//

import UIKit

final class AlertBuilder {
    
    typealias AlertActionHandler = () -> Void
    
    static func build(title: String?,
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
                                       style: .cancel) { _ in
                cancelHandler?()
            }
            alertVC.addAction(action)
        }
        if let okTitle {
            let action = UIAlertAction(title: okTitle, 
                                       style: .default) { _ in
                okHandler?()
            }
            alertVC.addAction(action)
        }
        return alertVC
    }
    
}
