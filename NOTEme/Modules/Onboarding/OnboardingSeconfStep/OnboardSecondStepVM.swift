//
//  OnboardSecondStepVM.swift
//  NOTEme
//
//  Created by Christina on 28.11.23.
//

import Foundation

import UIKit

protocol OnboardSecondStepCoordinatorProtocol: AnyObject {
    func finish()
    func dismissedByUser()
}

final class OnboardSecondStepVM: OnbordSecondStepViewModelProtocol {
  
    private weak var coordinator: OnboardSecondStepCoordinatorProtocol?
    
    init(coordinator: OnboardSecondStepCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    func doneDidTap() {
        ParametersHelper.set(.onboarded, value: true)
        coordinator?.finish()
    }
    
    func dismissedByUser() {
        coordinator?.dismissedByUser()
    }

}
