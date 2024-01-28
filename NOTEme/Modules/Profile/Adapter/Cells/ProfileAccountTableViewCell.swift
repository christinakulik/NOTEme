//
//  ProfileAccountTableViewCell.swift
//  NOTEme
//
//  Created by Christina on 26.12.23.
//

import UIKit
import SnapKit

class ProfileAccountTableViewCell: UITableViewCell {
    
    private enum L10n {
        static let emailLabel: String = "profile_account_email_label".localized
    }
    
    private lazy var emailLabel: UILabel = .subTitleLabel(L10n.emailLabel)
    
    private lazy var emailValueLabel: UILabel =
        .dataLabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
        addShadow()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ email: String) {
        emailValueLabel.text = email
    }
    
    func setupUI() {
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailValueLabel)
    }
    
    private func setupConstraints() {
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
        emailValueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalTo(emailLabel.snp.bottom).inset(-4.0)
        }
    }
}
