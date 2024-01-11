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
    //MARK: - TabBar
    enum TabBar {
        static let home: UIImage = .init(named: "home")!
        static let profile: UIImage = .init(named: "profile")!
        static let add: UIImage = .init(named: "add")!
    }
    //MARK: - Profile
    enum Profile {
        static let notifications: UIImage = .init(named: "notifications")!
        static let export: UIImage = .init(named: "export")!
        static let logout: UIImage = .init(named: "logout")!
    }
}
