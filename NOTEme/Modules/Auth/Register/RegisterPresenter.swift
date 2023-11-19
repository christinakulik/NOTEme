//
//  RegisterPresenter.swift
//  NOTEme
//
//  Created by Christina on 14.11.23.
//

import UIKit

protocol RegisterKeyboardHelperUseCase {
    @discardableResult
    func onWillShow(_ handler: @escaping KeyboardFrameHandler) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping KeyboardFrameHandler) -> Self
}

protocol RegisterInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol RegisterPresenterDelegate: AnyObject {
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPasswordError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
    
}

protocol RegisterAuthServiceUseCase {
    func register(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

final class RegisterPresenter: RegisterPresenterProtocol {
    
    weak var delegate: RegisterPresenterDelegate?
    
    private let authService: RegisterAuthServiceUseCase
    private let inputValidator: RegisterInputValidatorUseCase
    
    private let keyboardHelper: RegisterKeyboardHelperUseCase
    
    init(keyboardHelper: RegisterKeyboardHelperUseCase,
         authService: RegisterAuthServiceUseCase,
         inputValidator: RegisterInputValidatorUseCase) {
        self.keyboardHelper = keyboardHelper
        self.authService = authService
        self.inputValidator = inputValidator
        
        bind()
    }
    
    private func bind() {
        keyboardHelper.onWillShow { [weak self] frame in
            self?.delegate?.keyboardFrameChanged(frame)
        }.onWillHide { frame in
            self.delegate?.keyboardFrameChanged(frame)
        }
    }
    
    func registerDidTap(email: String?,
                        password: String?,
                        repeatPassword: String?) {
        guard
            checkValidation(email: email,
                            password: password,
                            repeatPassword: repeatPassword),
            let email, let password
        else { return }
        authService.register(email: email, 
                             password: password) { isSuccess in
            print(isSuccess)
        }
    }
    
    func haveAccountDidTap() {
        
    }
    
    private func checkValidation(email: String?,
                                 password: String?,
                                 repeatPassword: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        let isPasswordValid = inputValidator.validate(password: password)
        let isRepeatPasswordValid = repeatPassword == password
        
        delegate?.setEmailError(error: isEmailValid ? nil : "register_screen_email_errorText".localized)
        delegate?.setPasswordError(error: isPasswordValid ? nil : "register_screen_password_errorText".localized)
        delegate?.setRepeatPasswordError(error: isRepeatPasswordValid ? nil : "register_screen_repeatPassword_errorText".localized)
        
        return isEmailValid && isPasswordValid && isRepeatPasswordValid
    }
    
}
