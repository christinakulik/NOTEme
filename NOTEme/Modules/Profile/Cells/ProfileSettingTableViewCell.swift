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
    
    private lazy var containerView: UIView = .containerViewWithShadow()
    
    private lazy var notificationButton: UIButton =
        .withImageButton(L10n.notificationButton, 
                         image: .Profile.notifications,
                         color: .appBlack)
    
    private lazy var exportButton: UIButton =
        .withImageButton(L10n.exportButton, 
                         image: .Profile.export,
                         color: .appBlack)
    private lazy var logoutButton: UIButton =
        .withImageButton(L10n.logoutButton, 
                         image: .Profile.logout,
                         color: .appRed)
        .withAction(self, #selector(logoutDidTap))
    
    private lazy var hightSeparatedView: UIView = .separatedView()
    
    private lazy var lowSeparatedView: UIView = .separatedView()
    
    var onLogoutTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(containerView)
        containerView.addSubview(notificationButton)
        containerView.addSubview(exportButton)
        containerView.addSubview(logoutButton)
        containerView.addSubview(hightSeparatedView)
        containerView.addSubview(lowSeparatedView)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(-5.0)
            make.leading.equalTo(contentView.snp.leading).offset(20.0)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20.0)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
        hightSeparatedView.snp.makeConstraints { make in
            make.top.equalTo(notificationButton.snp.bottom).inset(-12.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.height.equalTo(1.0)
        }
        
        exportButton.snp.makeConstraints { make in
            make.top.equalTo(hightSeparatedView.snp.bottom).inset(-12.0)
            make.leading.equalToSuperview().inset(16.0)
        }
        
        lowSeparatedView.snp.makeConstraints { make in
            make.top.equalTo(exportButton.snp.bottom).inset(-12.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.height.equalTo(1.0)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(lowSeparatedView.snp.bottom).inset(-12.0)
            make.left.equalToSuperview().inset(16.0)
        }
        
    }
    
    @objc func logoutDidTap() {
        onLogoutTap?()
    }
}

