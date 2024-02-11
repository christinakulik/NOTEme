//
//  ProfileVM.swift
//  NOTEme
//
//  Created by Christina on 1.01.24.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func finish()
}

protocol ProfileAuthServiceUseCaseProtocol {
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

protocol ProfileAdapterProtocol {
    var didSelectRow: ((ProfileSettingsRows) -> Void)? { get set}
    
    func reloadData(with sections: [ProfileSections])
    func makeTableView() -> UITableView
}

final class ProfileVM: ProfileViewModelProtocol {
   
    private enum L10n {
        static let alertTitle: String = "profile_alert_title".localized
        static let alertMessage: String = "profile_alert_message".localized
        static let cancelTitle: String = "profile_alert_cancelTitle".localized
        static let destructiveTitle: String = "profile_alert_destTitle".localized
        static let userError: String = "profile_user_error".localized
    }
    
    private let authService: ProfileAuthServiceUseCaseProtocol
    private let alertService: ProfileAlertServiceUseCase
    private weak var coordinator: ProfileCoordinatorProtocol?
    private var adapter: ProfileAdapterProtocol
    
    private var sections: [ProfileSections] {
        return [
            .account(getCurrentEmail()),
            .settings(ProfileSettingsRows.allCases)
        ]
    }
    
    init(authService: ProfileAuthServiceUseCaseProtocol,
         alertService: ProfileAlertServiceUseCase,
         coordinator: ProfileCoordinatorProtocol,
         adapter: ProfileAdapterProtocol) {
        self.authService = authService
        self.alertService = alertService
        self.coordinator = coordinator
        self.adapter = adapter
        
        commonInit()
        bind()
    }
    
    func bind() {
        adapter.didSelectRow = { [weak self] row in
            switch row {
            case .logout:
                self?.logoutDidTap()
            default:
                break
            }
        }
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }

    private func commonInit() {
        adapter.reloadData(with: sections)
    }
    
    private func getCurrentEmail() -> String {
        return authService.currentUserEmail ?? L10n.userError
    }
    
    private func logoutDidTap() {
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


