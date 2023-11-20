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

protocol ResetAuthServiceUseCase {
    func reset(email: String, completion: @escaping (Bool) -> Void)
}

final class ResetVM: ResetViewModelProtocol {
    
    var catchEmailError: ((String?) -> Void)?
    
    private let authService: ResetAuthServiceUseCase
    private let inputValidator: ResetInputValidatorUseCase
    
    init(authService: ResetAuthServiceUseCase,
         inputValidator: ResetInputValidatorUseCase) {
        self.authService = authService
        self.inputValidator = inputValidator
    }
    
    func resetDidTap(email: String?) {
        guard
            checkValidation(email: email),
            let email
        else { return }
        authService.reset(email: email) { isSuccess in
            print(isSuccess)
        }
    }
    
    func cancelDidTap() { }
    
    private func checkValidation(email: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        
        catchEmailError?(isEmailValid ? nil :
                            "reset_screen_email_errorText".localized)
        
        return isEmailValid 
    }
}
