//
//  CreateDateAssembler.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit

final class CreateDateAssembler {
    private init() {}
    
    static func make(container: Container,
                     coordinator: CreateDateCoordinatorProtocol) -> UIViewController {
        
        let vm = CreateDateVM(coordinator: coordinator)
        
        return CreateDateVC(viewModel: vm)
    }
}
