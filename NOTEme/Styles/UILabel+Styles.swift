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
    
    static func infoLabelAttributes() -> UILabel {
        let label = UILabel()
        let text = "onbordSecondStep_screen_info_label".localized
        label.attributedText = .parse(html: text, font: .appFont.withSize(13))
        label.numberOfLines = .zero
        return label
    }
    
    static func selectionLabel(_ title: String?) -> UILabel {
        let label = UILabel()
        
        label.text = title
        label.font = .appFont.withSize(16.0)
        label.textColor = .appText
        label.numberOfLines = 0
        
        return label
    }

}
