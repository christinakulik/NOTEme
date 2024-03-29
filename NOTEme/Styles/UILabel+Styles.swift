//
//  UILabel+Styles.swift
//  NOTEme
//
//  Created by Christina on 31.10.23.
//

import UIKit

private enum L10n {
    static let infoLabelAttributes: String =
    "onbordSecondStep_screen_info_label".localized
}

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
        let text = L10n.infoLabelAttributes
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
    
    static func settingLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .appBoldFont.withSize(14.0)
        label.textColor = .appBlack
        return label
    }
    
    static func subTitleLabel(_ title: String?) -> UILabel {
        let label = UILabel()
        
        label.text = title
        label.font = .appFont.withSize(15.0)
        label.textColor = .appGraySubTitle
        return label
    }
    
    static func dataLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .appFont.withSize(17.0)
        label.textColor = .appText
        label.numberOfLines = 0
        
        return label
    }
    
    static func dataBoldLabel(_ title: String?) -> UILabel {
        let label = UILabel()
        
        label.text = title
        label.font = .appBoldFont.withSize(17.0)
        label.textColor = .appText
        label.numberOfLines = 0
        
        return label
    }
    
    static func profileLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .appFont.withSize(12.0)
        label.textColor = .appBlack
        label.numberOfLines = 0
        
        return label
    }
    
    static func titleCellLable() -> UILabel {
        let label = UILabel()
        
        label.font = .appBoldFont.withSize(15.0)
        label.textColor = .appBlack
        label.numberOfLines = 0
        
        return label
    }
    
    static func subTitleCellLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .appFont.withSize(13.0)
        label.textColor = .appDarkGray
        label.numberOfLines = 0
        
        return label
    }
    
    static func dayLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .appBoldFont.withSize(24.0)
        label.textColor = .appYellow
        label.numberOfLines = 0
        
        return label
    }
    
    static func monthLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .appBoldFont.withSize(14.0)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }
    
    static func largeLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .appBoldFont.withSize(25.0)
        label.textColor = .appBlack
        label.numberOfLines = 0
        
        return label
    }
}
