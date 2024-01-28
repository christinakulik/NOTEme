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
        
        let authUseCase = ProfileAuthServiceUseCase(authService:
                                                        container.resolve())
        let alertService: AlertService = container.resolve()
        
        let vm = ProfileVM(authService: authUseCase,
                           alertService: alertService,
                           coordinator: coordinator,
                           adapter: ProfileAdapter())
        return ProfileVC(viewModel: vm)
    }
}
