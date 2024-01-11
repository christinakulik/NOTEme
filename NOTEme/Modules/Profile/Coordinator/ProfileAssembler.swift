//
//  ProfileAssembler.swift
//  NOTEme
//
//  Created by Christina on 17.12.23.
//

import UIKit

final class ProfileAssembler {
    
    private init() {}
    
    static func make(coordinator: ProfileCoordinatorProtocol) -> UIViewController {
        let vm = ProfileVM(authService: AuthService(),
                           alertService: AlertService.current,
                           coordinator: coordinator)
        return ProfileVC(viewModel: vm)
    }
}
