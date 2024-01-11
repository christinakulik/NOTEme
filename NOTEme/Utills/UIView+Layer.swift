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
    
    func setBorder(with: CGFloat, color: UIColor) {
        layer.borderWidth = with
        layer.borderColor = color.cgColor
    }
    
}

extension CALayer {
    
  func applyShadow()  {
      
        self.shadowColor = UIColor.appBlack.withAlphaComponent(0.4).cgColor
        self.shadowOpacity = 1
        self.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowRadius = 5
    }
}

