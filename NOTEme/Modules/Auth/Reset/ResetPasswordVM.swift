//
//  ResetPasswordVM.swift
//  NOTEme
//
//  Created by Christina on 18.11.23.
//

import UIKit

protocol ResetInputValidatorUseCase {
    func validate(email: String?) -> Bool
 
}

