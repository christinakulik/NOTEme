//
//  Alert+Layer.swift
//  NOTEme
//
//  Created by Christina on 31.01.24.
//

import UIKit

extension UIAlertController {
   
    func addShadow() {
        self.view.subviews.first?.layer.shadowColor = UIColor.appBlack.withAlphaComponent(0.4).cgColor
        self.view.subviews.first?.layer.shadowOpacity = 1
        self.view.subviews.first?.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.view.subviews.first?.layer.shadowRadius = 5
    }
}
