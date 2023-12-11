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
    func showAlert(_ alert: UIAlertController)
}

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
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    
    init(coordinator: LoginCoordinatorProtocol,
         authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase) {
        self.coordinator = coordinator
        self.authService = authService
        self.inputValidator = inputValidator
    }
    
    func loginDidTap(email: String?, password: String?) {
        guard 
            checkValidation(email: email),
            let email, let password
        else { return }
        
        authService.login(email: email,
                          password: password) { [weak coordinator] isSuccess in
            print(isSuccess)
            if isSuccess {
                //FIXME: uncomment
                ParametersHelper.set(.authenticated, value: true)
                coordinator?.finish()
            } else {
                let alertVC = AlertBuilder
                    .build(title: "login_screen_errorAlert_title".localized,
                     message: "login_screen_errorAlert_message".localized,
                     okTitle: "OK")
                coordinator?.showAlert(alertVC)
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
        
        catchEmailError?(isEmailValid ? nil :
                            "login_screen_email_errorText".localized)
        
        return isEmailValid
    }
}
