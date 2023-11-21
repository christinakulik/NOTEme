//
//  RegisterAssembler.swift
//  NOTEme
//
//  Created by Christina on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let presenter = RegisterPresenter(keyboardHelper: KeyboardHelper(),
                                          authService: TESTAuthService(),
                                          inputValidator: InputValidator())
        let vc = RegisterVC(presenter: presenter, animate: KeyboardAnimator())
        presenter.delegate = vc
        
        return vc
    }
}

private class TESTAuthService: RegisterAuthServiceUseCase {
    func register(email: String,
                  password: String,
                  completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
