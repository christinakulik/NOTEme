//
//  String+Attributes.swift
//  NOTEme
//
//  Created by Christina on 4.12.23.
//

import UIKit

extension String {
    func changeFont(with desiredFont: UIFont = .appBoldFont.withSize(13.0))
    -> NSAttributedString {
        
        do {
            let regex = try NSRegularExpression(pattern: "\"([^\"]*)\"")
            
            let results = regex.matches(in: self, 
                                        range: NSRange(self.startIndex...,
                                                       in: self))
            
            let formattedString = NSMutableAttributedString.init(string: self)
            
            for result in results{
                formattedString.addAttribute(NSAttributedString.Key.font, 
                                             value: desiredFont,
                                             range: result.range)
            }
            
            return formattedString
            
        } catch let error {
            print("\(error.localizedDescription)")
            return NSAttributedString.init(string: self)
        }
    }
    
    
}
