//
//  String+Attributes.swift
//  NOTEme
//
//  Created by Christina on 4.12.23.
//

import UIKit

extension String {
    
    func setAttributes() -> NSAttributedString {
        
        let formattedString = NSMutableAttributedString.init(string: self)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        paragraphStyle.headIndent = 10.0
        formattedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                     value: paragraphStyle,
                                     range: NSRange(location: 0,
                                                    length: formattedString
                                        .length))
        
        return formattedString
    }
}
