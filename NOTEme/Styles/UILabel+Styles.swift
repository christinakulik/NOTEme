//
//  UILabel+Styles.swift
//  NOTEme
//
//  Created by Christina on 31.10.23.
//

import UIKit

extension UILabel {
    
    static func titleLabel(_ title: String?) -> UILabel {
        let label = UILabel()
        
        label.text = title
        label.font = .appBoldFont.withSize(25.0)
        label.textColor = .appText

        return label
    }
    
    static func infoLabel(_ title: String?) -> UILabel {
        let label = UILabel()
        
        label.text = title
        label.font = .appFont.withSize(13.0)
        label.textColor = .appText
        label.numberOfLines = 0
        
        return label
    }

}
