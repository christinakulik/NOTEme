//
//  UIButton+Styles.swift
//  NOTEme
//
//  Created by Christina on 31.10.23.
//

import UIKit

private enum L10n {
    static let cancelButton: String =
    "reset_screen_cancel_button".localized
}

extension UIButton {
    
    static func inputViewButton(_ title: String?, font: UIFont?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(.appYellow.withAlphaComponent(0.75),
                             for: .highlighted)
        
        button.titleLabel?.font = font?.withSize(15.0)
        
        return button
    }
    
    static func addButton() -> UIButton {
        let button = UIButton()
        button.setImage(.TabBar.add, for: .normal)
        button.cornerRadius = 25
        
        return button
    }
    
    static func editButton() -> UIButton {
        let button = UIButton()
        button.setImage(.Home.editor, for: .normal)
        
        return button
    }
    
    static func yellowRoundedButton(_ title: String?) -> UIButton {
       let button = UIButton()
        
        button.titleLabel?.font = .appBoldFont.withSize(17.0)
        button.backgroundColor = .appYellow
        button.cornerRadius = 5.0
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appText, for: .normal)
        button.setTitleColor(.appText.withAlphaComponent(0.75), 
                             for: .highlighted)
        
        return button
    }
    
    static func cancelButton() -> UIButton {
       let button = UIButton()
        
        button.backgroundColor = .clear
        button.cornerRadius = 5.0
        button.setBorder(with: 1.0, color: .appYellow)
        
        button.setTitle(L10n.cancelButton, for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(.appYellow.withAlphaComponent(0.75), 
                             for: .highlighted)
        
        button.titleLabel?.font = .appBoldFont.withSize(17.0)
       
        return button
    }
    
    static func underlineYellowButton(_ title: String) -> UIButton {
        return underlineButton(title, color: .appYellow,
                               font: .appBoldFont.withSize(17.0))
    }
    
    static func underlineGrayButton(_ title: String) -> UIButton {
        return underlineButton(title, color: .appGrayText,
                               font: .appBoldFont.withSize(15.0))
    }
    
    static func underlineButton(_ title: String,
                                color: UIColor,
                                font: UIFont) -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = .clear
        
        let normalAttr: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: color
        ]
        
        button.setAttributedTitle(.init(string: title, 
                                        attributes: normalAttr),
                                  for: .normal)
        
        let highlightedAttr: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color.withAlphaComponent(0.75),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: color.withAlphaComponent(0.75)
        ]
        
        button.setAttributedTitle(.init(string: title,
                                        attributes: highlightedAttr),
                                  for: .highlighted)
        return button
   }
    
}
