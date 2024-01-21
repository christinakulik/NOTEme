//
//  ProfileAssembler.swift
//  NOTEme
//
//  Created by Christina on 17.12.23.
//

import UIKit

final class ProfileAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: ProfileCoordinatorProtocol)
    -> UIViewController {
        
        let authService: AuthService = container.resolve()
        let alertService: AlertService = container.resolve()
        
        let vm = ProfileVM(authService: authService,
                           alertService: alertService,
                           coordinator: coordinator)
        return ProfileVC(viewModel: vm)
    }
}
