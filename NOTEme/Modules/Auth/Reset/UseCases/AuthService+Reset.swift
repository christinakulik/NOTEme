//
//  AuthService+Reset.swift
//  NOTEme
//
//  Created by Christina on 10.12.23.
//

import Foundation

extension AuthService: ResetAuthServiceUseCase {
    func reset(email: String, 
               completion: @escaping (Bool) -> Void) {
        self.sendPasswordReset(email: email,
                               completion: completion)
    }
}
