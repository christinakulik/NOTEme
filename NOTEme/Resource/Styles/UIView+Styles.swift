//
//  UIView+Layer.swift
//  NOTEme
//
//  Created by Christina on 30.10.23.
//

import UIKit

extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowRadius = 4
    }
    
}

