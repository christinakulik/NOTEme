//
//  AlertService+Profile.swift
//  NOTEme
//
//  Created by Christina on 2.01.24.
//

import UIKit

extension AlertService: ProfileAlertServiceUseCase {
    func showAlert(title: String,
                   message: String,
                   cancelTitle: String,
                   destructiveTitle: String,
                   destructiveHandler: @escaping() -> Void) {
        showAlert(title: title,
                  message: message,
                  cancelTitle: cancelTitle,
                  cancelHandler: nil, 
                  destructiveTitle: destructiveTitle,
                  destructiveHandler: destructiveHandler)
    }
}
