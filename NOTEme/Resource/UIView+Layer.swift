//
//  UIView+Layer.swift
//  NOTEme
//
//  Created by Christina on 30.10.23.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
        
    }
    
    func addBorder(with: CGFloat, color: UIColor) {
        
        layer.borderWidth = with
        layer.borderColor = color.cgColor
    }
    
}


