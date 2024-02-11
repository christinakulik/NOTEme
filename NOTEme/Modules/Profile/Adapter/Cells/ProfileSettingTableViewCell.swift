//
//  ProfileSettingTableViewCell.swift
//  NOTEme
//
//  Created by Christina on 26.12.23.
//

import UIKit
import SnapKit

class ProfileSettingTableViewCell: UITableViewCell {
    
    private lazy var settingsImageView = UIImageView()
    
    private lazy var settingsLabel: UILabel = .profileLabel()
    
    private lazy var statusLabel: UILabel = .profileLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ type: ProfileSettingsRows) {
        settingsLabel.text = type.title
        settingsLabel.textColor = type == .logout ? .appRed : .appBlack
        settingsImageView.image = type.icon
        statusLabel.text = type.infoText
    }
    
    func setupUI() {

        contentView.addSubview(settingsImageView)
        contentView.addSubview(settingsLabel)
        contentView.addSubview(statusLabel)
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
        
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16.0)
            make.verticalEdges.equalToSuperview().inset(12.0)
        }
    }
}

