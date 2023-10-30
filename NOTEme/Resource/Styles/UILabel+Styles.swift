//
//  UILabel+Styles.swift
//  NOTEme
//
//  Created by Christina on 31.10.23.
//

import UIKit


extension UILabel {
    
    func setAuthLabelStyle(_ title: String) {
        let label = self
        label.text = title
        label.font = .appBoldFont.withSize(25.0)
        label.textColor = .black
    }
}
