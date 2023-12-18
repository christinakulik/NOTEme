//
//  ResetAssembler.swift
//  NOTEme
//
//  Created by Christina on 18.11.23.
//

import Foundation


import UIKit

final class ResetAssembler {
    private init() {}
    
    static func make(coordinator: ResetCoordinatorProtocol) -> UIViewController {
        let vm = ResetVM(coordinator: coordinator,
                         authService: AuthService(),
                         inputValidator: InputValidator(),
                         alertService: AlertService.current)
        
        return ResetVC(viewModel: vm)
    }
}

