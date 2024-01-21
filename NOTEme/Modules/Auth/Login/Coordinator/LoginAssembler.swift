//
//  LoginAssembler.swift
//  NOTEme
//
//  Created by Christina on 10.11.23.
//

import UIKit

final class LoginAssembler {
    private init() {}
    
    static func make(container: Container,
                     coordinator: LoginCoordinatorProtocol) -> UIViewController {
        
        let authService: AuthService = container.resolve()
        let inputValidator: InputValidator = container.resolve()
        let alertService: AlertService = container.resolve()
        let keyboardHelper: KeyboardHelper = container.resolve()
        
        let vm = LoginVM(coordinator: coordinator,
                         authService: authService,
                         inputValidator: inputValidator,
                         keyboardHelper: keyboardHelper,
                         alertService: alertService)
        return LoginVC(viewModel: vm,
                       animator: KeyboardAnimator())
    }
}


