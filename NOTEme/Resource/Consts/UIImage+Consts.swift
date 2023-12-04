//
//  UIImage+Consts.swift
//  NoteMe
//
//  Created by Christina on 24.10.23.
//

import UIKit

extension UIImage {
    
    //MARK: - General
    enum General {
        static let logo: UIImage = .init(named: "logo")!
    }
    //MARK: - Onboarding
    enum Onboarding {
        static let step: UIImage = .init(named: "Step")!
    }
    enum Tabbar {
        static let home: UIImage = .init(named: "home")!
        static let homeSelected: UIImage = .init(named: "homeSelected")!
        static let profile: UIImage = .init(named: "profile")!
        static let profileSelected: UIImage = .init(named: "profileSelected")!
    }
    
}
