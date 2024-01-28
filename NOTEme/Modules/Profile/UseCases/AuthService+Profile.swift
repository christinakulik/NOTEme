//
//  AuthService+Profile.swift
//  NOTEme
//
//  Created by Christina on 2.01.24.
//

import Foundation

struct ProfileAuthServiceUseCase: ProfileAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    var currentUserEmail: String? {
        return authService.currentUserEmail
    }
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        authService.signOut(completion: completion)
    }
    
}

