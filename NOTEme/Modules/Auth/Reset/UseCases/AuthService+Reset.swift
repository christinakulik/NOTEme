//
//  AuthService+Reset.swift
//  NOTEme
//
//  Created by Christina on 10.12.23.
//

import Foundation

struct ResetAuthServiceUseCase: ResetAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func reset(email: String,
               completion: @escaping (Bool) -> Void) {
        authService.sendPasswordReset(email: email,
                               completion: completion)
    }
    
}

