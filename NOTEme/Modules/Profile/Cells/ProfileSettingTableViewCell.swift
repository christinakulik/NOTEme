//
//  ProfileSettingTableViewCell.swift
//  NOTEme
//
//  Created by Christina on 26.12.23.
//

import UIKit
import SnapKit

class ProfileSettingTableViewCell: UITableViewCell {
    
    private enum L10n {
        static let notificationButton: String =
        "profile_settings_notifications_button".localized
        static let exportButton: String =
        "profile_settings_export_button".localized
        static let logoutButton: String =
        "profile_settings_logout_button".localized
    }
    
    lazy var settingsImageView = UIImageView()
    
    lazy var settingsLabel: UILabel = .profileLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
//        selectionStyle = .none

        contentView.addSubview(settingsImageView)
        contentView.addSubview(settingsLabel)
    }
    
    private func setupConstraints() {
    
        settingsImageView.snp.makeConstraints { make in
            make.size.equalTo(16.0)
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(16.0)
        }
    
        settingsLabel.snp.makeConstraints { make in
            make.leading.equalTo(settingsImageView.snp.trailing).inset(-8.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
    }
    
}

