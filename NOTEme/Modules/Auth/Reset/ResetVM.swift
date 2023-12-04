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

protocol ResetAuthServiceUseCase {
    func reset(email: String, completion: @escaping (Bool) -> Void)
}

final class ResetVM: ResetViewModelProtocol {
   
    var showAlert: ((UIAlertController) -> Void)?
    
    var catchEmailError: ((String?) -> Void)?
    
    private weak var coordinator: ResetCoordinatorProtocol?
    
    private let authService: ResetAuthServiceUseCase
    private let inputValidator: ResetInputValidatorUseCase
    
    
    init(coordinator: ResetCoordinatorProtocol,
         authService: ResetAuthServiceUseCase,
         inputValidator: ResetInputValidatorUseCase) {
        self.coordinator = coordinator
        self.authService = authService
        self.inputValidator = inputValidator
    }
    
    func resetDidTap(email: String?) {
        guard
            checkValidation(email: email),
            let email
        else { return }
        authService.reset(email: email) { [weak self] isSuccess in
            print(isSuccess)
            self?.showSuccesAlert()
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    
    private func showSuccesAlert() {
        let alert = UIAlertController(
            title: "reset_screen_emailSuccessTitle_alert".localized,
            message: "reset_screen_emailSuccessMessage_alert".localized,
            preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: { _ in
            self.coordinator?.finish()
        }))
        showAlert?(alert)
    }
    
    private func checkValidation(email: String?) -> Bool {
        let isEmailValid = inputValidator.validate(email: email)
        
        catchEmailError?(isEmailValid ? nil :
                            "reset_screen_email_errorText".localized)
        
        return isEmailValid 
    }
}
