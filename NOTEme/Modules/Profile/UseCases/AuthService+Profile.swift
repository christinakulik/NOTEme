//
//  AuthService+Profile.swift
//  NOTEme
//
//  Created by Christina on 2.01.24.
//

import Foundation

extension AuthService: ProfileAuthServiceUseCase {
    func logout(completion: @escaping (Bool) -> Void) {
        self.signOut(completion: completion)
    }
}
