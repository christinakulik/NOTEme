//
//  UIView+Layer.swift
//  NOTEme
//
//  Created by Christina on 30.10.23.
//

import UIKit

extension UIView {
    
    func setYellowButtonStyle() {
        cornerRadius = 5.0
    }
    
    
    func setDefaultButtonStyle() {
        addBorder(with: 1.0, color: .appYellow)
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowRadius = 4
 
    }
    
}

extension UIButton {
    func addUnderline() {
        guard
            let text = self.titleLabel?.text
        else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor,
                                      value: self.titleColor(for: .normal)!,
                                      range: NSRange(location: 0,
                                                     length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: self.titleColor(for: .normal)!,
                                      range: NSRange(location: 0,
                                                     length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0,
                                                     length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
