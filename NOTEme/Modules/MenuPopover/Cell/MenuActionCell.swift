//
//  MenuActionCell.swift
//  NOTEme
//
//  Created by Christina on 27.02.24.
//

import UIKit
import SnapKit

protocol MenuActionItem {
    var title: String { get }
    var icon: UIImage? { get }
}

final class MenuActionCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = .selectionLabel(nil)
    
    private lazy var iconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: MenuActionItem) {
        titleLabel.text = item.title
        iconView.image = item.icon
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(8.0)
            make.right.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
            make.size.equalTo(24.0)
        }
    }
}
