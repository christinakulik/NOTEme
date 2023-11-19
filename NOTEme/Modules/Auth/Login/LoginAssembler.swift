//
//  LoginAssembler.swift
//  NOTEme
//
//  Created by Christina on 10.11.23.
//

import UIKit

final class LoginAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let vm = LoginVM(authService: TESTAuthService(),
        inputValidator: InputValidator())
        
        return LoginVC(viewModel: vm)
    }
    
    
}

private class TESTAuthService: LoginAuthServiceUseCase {
    func login(email: String, 
               password: String,
               completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    
}
