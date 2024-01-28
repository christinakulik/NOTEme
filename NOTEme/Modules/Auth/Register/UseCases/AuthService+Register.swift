//
//  AuthService+Register.swift
//  NOTEme
//
//  Created by Christina on 11.12.23.
//

import Foundation

struct RegisterAuthServiceUseCase: RegisterAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func register(email: String, 
                  password: String,
                  completion: @escaping (Bool) -> Void) {
        authService.createUser(email: email,
                               password: password,
                               completion: completion)
    }
    
    func sendEmailVerification() {
        authService.sendEmailVerification()
    }
    
}


