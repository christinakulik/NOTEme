//
//  ResetPasswordVM.swift
//  NOTEme
//
//  Created by Christina on 18.11.23.
//

import UIKit

protocol ResetCoordinatorProtocol: AnyObject {
    func finish()
}

protocol ResetInputValidatorUseCase {
    func validate(email: String?) -> Bool
    
}

protocol ResetAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitle: String)
}

protocol ResetAuthServiceUseCase {
    func reset(email: String,
               completion: @escaping (Bool) -> Void)
}

final class ResetVM: ResetViewModelProtocol {
    
    var catchEmailError: ((String?) -> Void)?
    
    private weak var coordinator: ResetCoordinatorProtocol?
    
    private let authService: ResetAuthServiceUseCase
    private let inputValidator: ResetInputValidatorUseCase
    private let alertService: ResetAlertServiceUseCase
    
    
    init(coordinator: ResetCoordinatorProtocol,
         authService: ResetAuthServiceUseCase,
         inputValidator: ResetInputValidatorUseCase,
         alertService: ResetAlertServiceUseCase) {
        self.coordinator = coordinator
        self.authService = authService
        self.inputValidator = inputValidator
        self.alertService = alertService
    }
    
    func resetDidTap(email: String?) {
        guard
            checkValidation(email: email),
            let email
        else { return }
        authService.reset(email: email) { [weak self] isSuccess in
            print(isSuccess)
            if isSuccess {
                self?.alertService
                    .showAlert(
                        title: "reset_screen_emailSuccessTitle_alert".localized,
                        message: "reset_screen_emailSuccessMessage_alert".localized,
                        okTitle: "OK")
                self?.coordinator?.finish()
            } else {
                self?.alertService
                    .showAlert(
                        title: "reset_screen_emailSuccessTitle_alert".localized,
                        message: "reset_screen_emailSuccessMessage_alert".localized,
                        okTitle: "OK")
            }
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    private func checkValidation(email: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        
        catchEmailError?(isEmailValid ? nil :
                            "reset_screen_email_errorText".localized)
        
        return isEmailValid 
    }
}
