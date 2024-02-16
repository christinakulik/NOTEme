//
//  PopoverTableViewCell.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import SnapKit

class PopoverTableViewCell: UITableViewCell {

    private lazy var popoverImageView = UIImageView()
    
    private lazy var selectedLabel: UILabel = .selectionLabel(nil)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ type: PopoverRows) {
        selectedLabel.text = type.title
        popoverImageView.image = type.icon
    }
    
    func setupUI() {

        contentView.addSubview(popoverImageView)
        contentView.addSubview(selectedLabel)
    
    }
    
    private func setupConstraints() {
            
            selectedLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16.0)
                make.centerY.equalToSuperview()
            }
            
            popoverImageView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(8.0)
                make.top.equalToSuperview().inset(8.0)
                make.size.equalTo(24.0)
            }
        }
    }
