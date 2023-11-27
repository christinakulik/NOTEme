//
//  RegisterPresenter.swift
//  NOTEme
//
//  Created by Christina on 14.11.23.
//

import UIKit

protocol RegisterCoordinatorProtocol: AnyObject {
    func finish()
}

protocol RegisterInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol RegisterKeyboardHelperUseCase {
   
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> Self
}

protocol RegisterAuthServiceUseCase {
    func register(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol RegisterPresenterDelegate: AnyObject {
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPasswordError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
    
}

final class RegisterPresenter: RegisterPresenterProtocol {
    
    weak var delegate: RegisterPresenterDelegate?
    
    private weak var coordinator: RegisterCoordinatorProtocol?
    
    private let authService: RegisterAuthServiceUseCase
    private let inputValidator: RegisterInputValidatorUseCase
    private let keyboardHelper: RegisterKeyboardHelperUseCase
    
    init(coordinator: RegisterCoordinatorProtocol,
         keyboardHelper: RegisterKeyboardHelperUseCase,
         authService: RegisterAuthServiceUseCase,
         inputValidator: RegisterInputValidatorUseCase) {
        self.coordinator = coordinator
        self.keyboardHelper = keyboardHelper
        self.authService = authService
        self.inputValidator = inputValidator
        
        bind()
    }

    func bind() {
       keyboardHelper
          .onWillShow { [weak self] in
              self?.delegate?.keyboardFrameChanged($0)
          }.onWillHide { [weak self] in
              self?.delegate?.keyboardFrameChanged($0)
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
                             password: password) {
            [weak coordinator] isSuccess in
            print(isSuccess)
            coordinator?.finish()
        }
    }
    
    func haveAccountDidTap() { 
        coordinator?.finish()
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
