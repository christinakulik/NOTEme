//
//  ProfileHeaderView.swift
//  NOTEme
//
//  Created by Christina on 2.01.24.
//

import UIKit
import SnapKit


final class ProfileHeaderView: UIView {
    
    private lazy var titleLabel: UILabel = .settingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        
    }
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16.0)
        }
    }
    
    func set(with title: String) {
        titleLabel.text = title
    }
}
