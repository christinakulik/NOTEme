//
//  CreateTimerAssembler.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit

final class CreateTimerAssembler {
    private init() {}
    
    static func make(container: Container,
                     coordinator: CreateTimerCoordinatorProtocol) -> UIViewController {
        
        let vm = CreateTimerVM(coordinator: coordinator)
        
        return CreateTimerVC(viewModel: vm)
    }
}

