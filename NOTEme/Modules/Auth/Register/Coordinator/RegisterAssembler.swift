//
//  RegisterAssembler.swift
//  NOTEme
//
//  Created by Christina on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    private init() {}
    
    static func make(container: Container,
                     coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        
        let authUseCase = RegisterAuthServiceUseCase(authService:
                                                        container.resolve())
        let inputValidator: InputValidator = container.resolve()
        let alertService: AlertService = container.resolve()
        let keyboardHelper: KeyboardHelper = container.resolve()
        let presenter = RegisterPresenter(coordinator: coordinator,
                                          keyboardHelper: keyboardHelper,
                                          authService: authUseCase,
                                          inputValidator: inputValidator,
                                          alertService: alertService)
        let vc = RegisterVC(presenter: presenter, animate: KeyboardAnimator())
        presenter.delegate = vc
        
        return vc
    }
}
