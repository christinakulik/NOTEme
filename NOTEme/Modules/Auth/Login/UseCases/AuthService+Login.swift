//
//  AuthService+Login.swift
//  NOTEme
//
//  Created by Christina on 5.12.23.
//

import Foundation

struct LoginAuthServiceUseCase: LoginAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func login(email: String, 
               password: String,
               completion: @escaping (Bool) -> Void) {
        authService.signIn(email: email,
                           password: password,
                           completion: completion)
    }
    
}

//extension AuthService: LoginAuthServiceUseCase {
//    func login(email: String, 
//               password: String,
//               completion: @escaping (Bool) -> Void) {
//        self.signIn(email: email,
//                    password: password,
//                    completion: completion)
//    }
//}
