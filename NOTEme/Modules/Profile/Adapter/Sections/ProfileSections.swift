//
//  ProfileSections.swift
//  NOTEme
//
//  Created by Christina on 24.01.24.
//

import UIKit

fileprivate enum L10n {
    static let accountTitle: String = "profile_section_account".localized
    static let settingsTitle: String = "profile_section_settings".localized
    static let notificationLabel: String = "profile_notify_label".localized
    static let exportLabel: String = "profile_export_label".localized
    static let logoutLabel: String = "profile_logout_label".localized
}

enum ProfileSections {
    
    case account(String)
    case settings([ProfileSettingsRows])
    
    var numberOfRows: Int {
        switch self {
        case .settings(let rows): return rows.count
        default: return 1
        }
    }
    
    var headerText: String {
        switch self {
        case .account: return L10n.accountTitle
        case .settings(_): return L10n.settingsTitle
        }
    }
}

enum ProfileSettingsRows: CaseIterable {
    
    case notifications
    case export
    case map
    case logout
    
    var icon: UIImage {
        switch self {
        case .notifications: return .Profile.notifications
        case .export: return .Profile.export
        case .map: return .Location.locationIcon
        case .logout: return .Profile.logout
        }
    }
    
    var title: String {
        switch self {
        case .notifications: return L10n.notificationLabel
        case .export: return L10n.exportLabel
        case .logout: return L10n.logoutLabel
        case .map: return "Map"
        }
    }
    
    var infoText: String? {
        switch self {
        case .export: return "Now"
        default: return nil
        }
    }
}
