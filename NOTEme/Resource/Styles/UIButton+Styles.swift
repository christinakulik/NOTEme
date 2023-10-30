//
//  UIButton+Styles.swift
//  NOTEme
//
//  Created by Christina on 31.10.23.
//

import UIKit


extension UIButton {
    
    func setYellowButtonStyle(_ title: String) {
       let button = self
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .appBoldFont
        button.backgroundColor = .appYellow
        button.cornerRadius = 5.0
    }
    
     func setUnderScopeButtonStyle(_ title: String) {
        let button = self
        button.setTitle(title, for: .normal)
        button.setTitleColor(.yellow, for: .normal)
         button.titleLabel?.font = .appBoldFont
        button.addUnderline()
    }
    
    func setUnderlineButtonStyle() {
       let button = self
       button.setTitle("Forgot Password", for: .normal)
       button.setTitleColor(.lightGray, for: .normal)
       button.titleLabel?.font = .appBoldFont.withSize(15)
       button.contentHorizontalAlignment = .left
       button.addUnderline()
   }
    
    func addUnderline() {
        guard
            let text = self.titleLabel?.text
        else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor,
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
