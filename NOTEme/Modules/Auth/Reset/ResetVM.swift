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
        authService.reset(email: email) { [weak coordinator]isSuccess in
            print(isSuccess)
            coordinator?.finish()
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
