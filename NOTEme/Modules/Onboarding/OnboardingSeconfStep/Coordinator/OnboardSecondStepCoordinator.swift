//
//  OnboardSecondStepCoordinator.swift
//  NOTEme
//
//  Created by Christina on 28.11.23.
//

import UIKit

final class OnboardSecondStepCoordinator: Coordinator {
    
    var onDismissedByUser:((Coordinator) -> Void)?

    override func start() -> UIViewController {
        return  OnboardSecondStepAssembler.make(self)
    }
    
    
}

extension OnboardSecondStepCoordinator: OnboardSecondStepCoordinatorProtocol {
    func dismissedByUser() {
        onDismissedByUser?(self)
    }
}
