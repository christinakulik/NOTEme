//
//  AuthService.swift
//  NOTEme
//
//  Created by Christina on 5.12.23.
//

import Foundation
import FirebaseAuth

final class AuthService {
    
    private var firebase: Auth {
        return Auth.auth()
    }
    
    private var user: User? {
        return Auth.auth().currentUser
    }
    
    var currentUserEmail: String? {
            return user?.email
        }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Bool) -> Void) {
        firebase.signIn(withEmail: email,
                        password: password) { result, error in
                completion(error == nil)
        }
    }
    
    func createUser(email: String,
                    password: String,
                    completion: @escaping (Bool) -> Void) {
        firebase.createUser(withEmail: email,
                            password: password) { result, error in
            completion(error == nil)
        }
    }
    
    
    func sendPasswordReset(email: String,
                           completion: @escaping (Bool) -> Void) {
        firebase.sendPasswordReset(withEmail: email) { error in
            completion(error == nil)
        }
    }
    
    func sendEmailVerification() {
            user?.sendEmailVerification()
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try firebase.signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
}



