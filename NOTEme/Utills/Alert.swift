//
//  Alert.swift
//  NOTEme
//
//  Created by Christina on 27.11.23.
//

import UIKit

extension UIViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Email address sent successfully",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", 
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
    }
}
