//
//  AnnotationsMapVM.swift
//  NOTEme
//
//  Created by Christina on 8.04.24.
//

import UIKit

protocol AnnotationsMapCoordinatorProtocol {
    func finish()
}

final class AnnotationsMapVM: AnnotationsMapViewModelProtocol {
    
    private let coordinator: AnnotationsMapCoordinatorProtocol
    
    init(coordinator: AnnotationsMapCoordinatorProtocol) {
        self.coordinator = coordinator
    }
   
    func finishDidTap() {
        coordinator.finish()
    }
}
