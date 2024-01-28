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

protocol RegisterAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitle: String)
}

protocol RegisterAuthServiceUseCaseProtocol {
    func register(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
    func sendEmailVerification()
}

protocol RegisterPresenterDelegate: AnyObject {
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPasswordError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
    
}

final class RegisterPresenter: RegisterPresenterProtocol {
    
    private enum L10n {
        static let titleAlert: String =
        "register_screen_successAlert_title".localized
        static let messageAlert: String =
        "register_screen_successAlert_message".localized
        static let errorTitleAlert: String =
        "register_screen_errorAlert_title".localized
        static let errorMessageAlert: String =
        "register_screen_errorAlert_message".localized
        static let errorText: String =
        "register_screen_repeatPassword_errorText".localized
        static let emailErrorText: String =
        "register_screen_email_errorText".localized
        static let passwordErrorText: String =
        "register_screen_password_errorText".localized
    }
    
    weak var delegate: RegisterPresenterDelegate?
    
    private weak var coordinator: RegisterCoordinatorProtocol?
    
    private let authService: RegisterAuthServiceUseCaseProtocol
    private let inputValidator: RegisterInputValidatorUseCase
    private let keyboardHelper: RegisterKeyboardHelperUseCase
    private let alertService: RegisterAlertServiceUseCase
    
    init(coordinator: RegisterCoordinatorProtocol,
         keyboardHelper: RegisterKeyboardHelperUseCase,
         authService: RegisterAuthServiceUseCaseProtocol,
         inputValidator: RegisterInputValidatorUseCase,
         alertService: RegisterAlertServiceUseCase) {
        self.coordinator = coordinator
        self.keyboardHelper = keyboardHelper
        self.authService = authService
        self.inputValidator = inputValidator
        self.alertService = alertService
        
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
            [weak self] isSuccess in
            print(isSuccess)
            if isSuccess {
                self?.authService.sendEmailVerification()
                self?.alertService
                    .showAlert(
                        title: L10n.titleAlert,
                        message: L10n.messageAlert,
                        okTitle: "OK")
                self?.coordinator?.finish()
            } else {
                self?.alertService
                    .showAlert(
                        title: L10n.errorMessageAlert,
                        message: L10n.errorMessageAlert,
                        okTitle: "OK")
            }
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
        
        delegate?.setEmailError(error: isEmailValid ? nil : 
                                    L10n.emailErrorText)
        delegate?.setPasswordError(error: isPasswordValid ? nil :
                                    L10n.passwordErrorText)
        delegate?.setRepeatPasswordError(error: isRepeatPasswordValid ? nil :
                                            L10n.errorText)
        
        return isEmailValid && isPasswordValid && isRepeatPasswordValid
    }
}
