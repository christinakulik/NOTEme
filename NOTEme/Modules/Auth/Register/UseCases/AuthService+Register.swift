//
//  AuthService+Register.swift
//  NOTEme
//
//  Created by Christina on 11.12.23.
//

import Foundation

extension AuthService: RegisterAuthServiceUseCase {
    
    func register(email: String,
                  password: String,
                  completion: @escaping (Bool) -> Void) {
        self.createUser(email: email,
                        password: password,
                        completion: completion)
    }
}
