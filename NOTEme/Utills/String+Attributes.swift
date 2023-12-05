//
//  String+Attributes.swift
//  NOTEme
//
//  Created by Christina on 4.12.23.
//

import UIKit

extension String {
    func setAttributes(with desiredFont: UIFont = .appBoldFont.withSize(13.0))
    -> NSAttributedString {
        
        do {
            let regex = try NSRegularExpression(pattern: "(?<=\\•\\s)(\\w+)")
            
            let results = regex.matches(in: self, 
                                        range: NSRange(self.startIndex...,
                                                       in: self))
            
            let formattedString = NSMutableAttributedString.init(string: self)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.left
            
            paragraphStyle.headIndent = 10.0
            formattedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: paragraphStyle,
                                         range: NSRange(location: 0,
                                                        length: formattedString.length))
            
            for result in results {
                formattedString.addAttributes([NSAttributedString.Key.font: 
                                                desiredFont],
                                              range: result.range)
            }
            
            return formattedString
            
        } catch let error {
            print("\(error.localizedDescription)")
            return NSAttributedString.init(string: self)
        }
    }
    
    
    
}
