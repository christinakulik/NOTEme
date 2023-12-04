//
//  OnboardFirstStepVM.swift
//  NOTEme
//
//  Created by Christina on 28.11.23.
//

import UIKit

protocol OnboardFirstStepCoordinatorProtocol: AnyObject {
    func openNextStep()
}

final class OnboardFirstStepVM: OnbordFirstStepViewModelProtocol {
    
    private weak var coordinator: OnboardFirstStepCoordinatorProtocol?
    
    init(coordinator: OnboardFirstStepCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    func nextDidTap() {
        coordinator?.openNextStep()
    }

}
