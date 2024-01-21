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
    static let notificationLabel: String =
    "profile_settings_notifications_button".localized
    static let exportLabel: String =
    "profile_settings_export_button".localized
    static let logoutLabel: String =
    "profile_settings_logout_button".localized
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

enum ProfileSettings {
    case notifications
    case export
    case logout

    var label: String {
        switch self {
        case .notifications: return L10n.notificationLabel
        case .export: return L10n.exportLabel
        case .logout: return L10n.logoutLabel
        }
    }

    var image: UIImage {
        switch self {
        case .notifications: return .Profile.notifications
        case .export: return .Profile.export
        case .logout: return .Profile.logout
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
        switch ProfileSection(rawValue: section) {
         case .account:
             return 1
         case .settings:
             return 3
         case .none:
             return 0
         }
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        return ProfileSection(rawValue: section)?.title
    }
    
    func dataForCell(at indexPath: IndexPath) -> ProfileSettings? {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
            return nil
        }
        
        switch section {
        case .account:
            return nil
        case .settings:
            switch indexPath.row {
            case 0: return .notifications
            case 1: return .export
            case 2: return .logout
            default: return nil
            }
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
            switch ProfileSection(rawValue: indexPath.section) {
            case .account:
                return 73
            case .settings:
                return 44
            case .none:
                return 0 
            }
        }
    
   func getCurrentEmail() -> String {
       return authService.currentUserEmail ?? L10n.userError
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


