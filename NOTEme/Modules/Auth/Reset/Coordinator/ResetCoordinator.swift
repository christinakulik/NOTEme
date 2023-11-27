//
//  ResetCoordinator.swift
//  NOTEme
//
//  Created by Christina on 27.11.23.
//

import UIKit

final class ResetCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return ResetAssembler.make(coordinator: self)
    }
}

extension ResetCoordinator: ResetCoordinatorProtocol {}
