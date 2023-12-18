//
//  RegisterAssembler.swift
//  NOTEme
//
//  Created by Christina on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    private init() {}
    
    static func make(coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        let presenter = RegisterPresenter(coordinator: coordinator,
                                          keyboardHelper: KeyboardHelper(),
                                          authService: AuthService(),
                                          inputValidator: InputValidator(),
                                          alertService: AlertService.current)
        let vc = RegisterVC(presenter: presenter, animate: KeyboardAnimator())
        presenter.delegate = vc
        
        return vc
    }
}
