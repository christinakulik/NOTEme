//
//  LoginVM.swift
//  NOTEme
//
//  Created by Christina on 10.11.23.
//

import UIKit

protocol LoginInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

final class LoginVM: LoginViewModelProtocol {
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    
    init(authService: LoginAuthServiceUseCase, 
         inputValidator: LoginInputValidatorUseCase) {
        self.authService = authService
        self.inputValidator = inputValidator
    }
    
    func loginDidTap(email: String?, password: String?) {
        guard 
            checkValidation(email: email, password: password),
            let email, let password
        else { return }
        authService.login(email: email,
                          password: password) { isSuccess in
            print(isSuccess)
        }
    }
    
    func newAccountDidTap() { 
        
    }
    
    func forgotPasswordDidTap(email: String?) { 
        
    }
    
    private func checkValidation(email: String?, password: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        let isPAsswordValid = inputValidator.validate(password: password)
        
        catchEmailError?(isEmailValid ? nil :
                            "login_screen_email_errorText".localized)
        catchPasswordError?(isPAsswordValid ? nil :
                                "login_screen_password_errorText".localized)
        
        return isEmailValid && isPAsswordValid
    }
}
