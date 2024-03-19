//
//  RouteTableViewCell.swift
//  NOTEme
//
//  Created by Christina on 12.03.24.
//

import UIKit
import SnapKit
import MapKit

class RouteTableViewCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView =
    UIImageView(image: .Location.locationIcon)
    
    private lazy var locationLabel: UILabel = .profileLabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ type: MKMapItem) {
        locationLabel.text = type.name
    }
    
    func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(locationLabel)
     
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(23.0)
            make.width.equalTo(16.0)
            make.trailing.equalToSuperview().inset(20.0)
            make.centerY.equalToSuperview()
        }
    
        locationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(-2.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
    }
}
