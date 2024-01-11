//
//  ProfileAccountTableViewCell.swift
//  NOTEme
//
//  Created by Christina on 26.12.23.
//

import UIKit
import SnapKit
import FirebaseAuth

class ProfileAccountTableViewCell: UITableViewCell {
    
    private enum L10n {
        static let emailLabel: String = "profile_account_email_label".localized
    }
    
    private lazy var containerView: UIView = .containerViewWithShadow()
    
    private lazy var emailLabel: UILabel = .subTitleLabel("Your e-mail:")
    
    private lazy var emailValueLabel: UILabel =
        .dataLabel()
    
    
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
        containerView.addSubview(emailLabel)
        containerView.addSubview(emailValueLabel)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(-5.0)
            make.leading.equalTo(contentView.snp.leading).offset(20.0)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20.0)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
        emailValueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalTo(emailLabel.snp.bottom).inset(-4.0)
        }
    }
    
    func setup(with model: ProfileAccountModel) {
        emailValueLabel.text = model.email
        }
}
