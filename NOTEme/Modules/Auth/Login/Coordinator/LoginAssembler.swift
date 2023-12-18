//
//  LoginAssembler.swift
//  NOTEme
//
//  Created by Christina on 10.11.23.
//

import UIKit

final class LoginAssembler {
    private init() {}
    
    static func make(coordinator: LoginCoordinatorProtocol) -> UIViewController {
        let vm = LoginVM(coordinator: coordinator,
                         authService: AuthService(),
                         inputValidator: InputValidator(),
                         keyboardHelper: KeyboardHelper(),
                         alertService: AlertService.current)
        return LoginVC(viewModel: vm,
                       animator: KeyboardAnimator())
    }
}


