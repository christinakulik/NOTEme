//
//  InputValidator.swift
//  NOTEme
//
//  Created by Christina on 10.11.23.
//

import UIKit

final class InputValidator {
    
    func validate(email: String?) -> Bool {
        return validate(string: email,
                        pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
    }
    
    func validate(password: String?) -> Bool {
        return validate(string: password,
                        pattern: "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&? \"]).*$)")
    }
    
    
    private func validate(string: String?, pattern: String) -> Bool {
        guard
            let string,
            let regex = try? NSRegularExpression(pattern: pattern,
                                                 options: .caseInsensitive)
        else { return false }
        
        let match = regex.firstMatch(in: string,
                                     options: [],
                                     range: NSRange(location: 0, 
                                                    length: string.count))
        return match != nil
    }
}



