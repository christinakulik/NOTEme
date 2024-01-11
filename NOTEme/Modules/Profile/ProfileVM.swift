//
//  ProfileVM.swift
//  NOTEme
//
//  Created by Christina on 1.01.24.
//

import UIKit

private enum L10n {
    static let alertTitle: String = "profile_alert_title".localized
    static let alertMessage: String = "profile_alert_message".localized
    static let cancelTitle: String = "profile_alert_cancelTitle".localized
    static let destructiveTitle: String = "profile_alert_destTitle".localized
    static let userError: String = "profile_user_error".localized
    static let accountTitle: String = "profile_section_account".localized
    static let settingsTitle: String = "profile_section_settings".localized
}

enum ProfileSection: Int, CaseIterable {
    case account
    case settings

    var title: String {
        switch self {
        case .account:
            return L10n.accountTitle
        case .settings:
            return L10n.settingsTitle
        }
    }
}

protocol ProfileCoordinatorProtocol: AnyObject {
    func finish()
}

protocol ProfileAuthServiceUseCase {
    func logout(completion: @escaping (Bool) -> Void)
    var currentUserEmail: String? { get }
}

protocol ProfileAlertServiceUseCase {
    func showAlert(title: String,
                   message: String,
                   cancelTitle: String,
                   destructiveTitle: String,
                   destructiveHandler: @escaping() -> Void)
}

final class ProfileVM: ProfileViewModelProtocol {
    
    private let authService: ProfileAuthServiceUseCase
    private let alertService: ProfileAlertServiceUseCase
    private weak var coordinator: ProfileCoordinatorProtocol?
    
    init(authService: ProfileAuthServiceUseCase,
         alertService: ProfileAlertServiceUseCase,
         coordinator: ProfileCoordinatorProtocol) {
        self.authService = authService
        self.alertService = alertService
        self.coordinator = coordinator
    }
    
    func numberOfSections() -> Int {
        return ProfileSection.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 1
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        return ProfileSection(rawValue: section)?.title
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
            switch ProfileSection(rawValue: indexPath.row) {
            case .account:
                return 44
            case .settings:
                return 44
            case .none:
                return 0 
            }
        }
    
    func getCurrentEmail() -> ProfileAccountModel {
        let currentEmail = authService.currentUserEmail ?? L10n.userError
        let accountProfile = ProfileAccountModel(email: currentEmail)
        return accountProfile
    }
    
    func logoutDidTap() {
        alertService.showAlert(title: L10n.alertTitle,
                               message: L10n.alertMessage,
                               cancelTitle: L10n.cancelTitle,
                               destructiveTitle: L10n.destructiveTitle,
                               destructiveHandler: {
            self.authService.logout { [weak self] isSuccess in
                if isSuccess {
                    ParametersHelper.set(.authenticated, value: false)
                    ParametersHelper.set(.onboarded, value: false)
                    self?.coordinator?.finish()
                }
            }
        })
    }
}


