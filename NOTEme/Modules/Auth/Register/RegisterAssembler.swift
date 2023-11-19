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
                                          authService: TESTRegisterService(),
                                          inputValidator: InputValidator())
        let vc = RegisterVC(presenter: presenter)
        
        presenter.delegate = vc
        
        return vc
    }
   
}

private class TESTRegisterService: RegisterAuthServiceUseCase {
    func register(email: String, 
                  password: String,
                  completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
