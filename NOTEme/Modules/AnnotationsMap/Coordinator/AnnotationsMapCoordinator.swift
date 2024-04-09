//
//  AnnotationsMapCoordinator.swift
//  NOTEme
//
//  Created by Christina on 8.04.24.
//

import UIKit

final class AnnotationsMapCoordinator: Coordinator, AnnotationsMapCoordinatorProtocol {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = AnnotationsMapAssembler.make(self)
        return vc
    }
}
