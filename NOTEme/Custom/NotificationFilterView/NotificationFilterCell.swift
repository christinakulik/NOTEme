//
//  NotificationFilterCell.swift
//  NOTEme
//
//  Created by Christina on 15.03.24.
//

import UIKit
import SnapKit

final class NotificationFilterCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(17.0)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            setSelectedUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with type: NotificationFilterType) {
        titleLabel.text = type.title
    }
    
    private func setupUI() {
        contentView.cornerRadius = 5.0
        contentView.backgroundColor = .appGrayCell
        contentView.addSubview(titleLabel)
        
    }
    private func setupConstraits() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setSelectedUI() {
        if isSelected {
            contentView.backgroundColor = .appYellow
            titleLabel.font = .appBoldFont.withSize(17.0)
        } else {
            contentView.backgroundColor = .appGrayCell
            titleLabel.font = .appFont.withSize(17.0)
        }
    }
}



