//
//  LoginVM.swift
//  NOTEme
//
//  Created by Christina on 10.11.23.
//

import UIKit
import FirebaseAuth

protocol LoginCoordinatorProtocol: AnyObject {
    func finish()
    func openRegisterModule()
    func openResetModule()
}

protocol LoginInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol LoginAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitle: String)
}

protocol LoginKeyboardHelperUseCase {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> Self
}

protocol LoginAuthServiceUseCaseProtocol {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

final class LoginVM: LoginViewModelProtocol {
    
    private enum L10n {
        static let titleAlert: String =
        "login_screen_errorAlert_title".localized
        static let messageAlert: String =
        "login_screen_errorAlert_message".localized
        static let errorText: String =
        "login_screen_email_errorText".localized
    }
   
    var changeKeyboardFrame: ((CGRect) -> Void)?
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let authService: LoginAuthServiceUseCaseProtocol
    private let inputValidator: LoginInputValidatorUseCase
    private let keyboardHelper: LoginKeyboardHelperUseCase
    private let alertService: LoginAlertServiceUseCase
    
    init(coordinator: LoginCoordinatorProtocol,
         authService: LoginAuthServiceUseCaseProtocol,
         inputValidator: LoginInputValidatorUseCase,
         keyboardHelper: LoginKeyboardHelperUseCase,
         alertService: LoginAlertServiceUseCase) {
        self.coordinator = coordinator
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        self.alertService = alertService
        
        bind()
    }
    
    func bind() {
       keyboardHelper
          .onWillShow { [weak self] in
              self?.changeKeyboardFrame?($0)
          }.onWillHide { [weak self] in
              self?.changeKeyboardFrame?($0)
          }
    }
    
    func loginDidTap(email: String?, password: String?) {
        guard 
            checkValidation(email: email),
            let email, let password
        else { return }
        authService.login(email: email,
                          password: password) { [weak self] isSuccess in
            print(isSuccess)
            if isSuccess {
                ParametersHelper.set(.authenticated, value: true)
                self?.coordinator?.finish()
            } else {
                self?.alertService
                    .showAlert(
                        title: L10n.titleAlert,
                        message: L10n.messageAlert,
                    okTitle: "OK")
                
            }
        }
    }
    
    func newAccountDidTap() { 
        print("\(#function)")
        coordinator?.openRegisterModule()
    }
    
    func forgotPasswordDidTap(email: String?) { 
        print("\(#function)")
        coordinator?.openResetModule()
    }
    
    private func checkValidation(email: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        
        catchEmailError?(isEmailValid ? nil : L10n.errorText)
        
        return isEmailValid
    }
}
