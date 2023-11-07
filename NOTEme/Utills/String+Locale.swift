//
//  String+Locale.swift
//  NOTEme
//
//  Created by Christina on 5.11.23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
