//
//  ProfileCoordinator.swift
//  NOTEme
//
//  Created by Christina on 17.12.23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return ProfileAssembler.make(coordinator: self)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
 
}
