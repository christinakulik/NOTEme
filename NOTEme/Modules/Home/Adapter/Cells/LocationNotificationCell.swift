//
//  LocationNotificationCell.swift
//  NOTEme
//
//  Created by Christina on 23.02.24.
//

import UIKit
import SnapKit
import Storage

final class LocationNotificationCell: UITableViewCell {
    
    var buttonDidTap: ((_ sender: UIButton) -> Void)?
    
    private lazy var titleLabel: UILabel = .titleCellLable()
    private lazy var subTitleLabel: UILabel = .subTitleCellLabel()
    
    private lazy var containerView: UIView = .plainViewWithShadow()
    
    private lazy var iconImageView: UIImageView =
    UIImageView(image: .Home.location)
    
    private lazy var button: UIButton = .editButton()
        .withAction(self, #selector(editDidTap))
    
    private lazy var locationImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCell()
   }

    private func setupCell() {
        backgroundColor = .clear
      
    }
    
    @objc private func editDidTap(sender: UIButton) {
        buttonDidTap?(sender)
    }
    
    func setup(_ type: any DTODescription) {
        guard let locationNotificationDTO = type as? LocationNotificationDTO
        else { return }
        
        titleLabel.text = locationNotificationDTO.title
        subTitleLabel.text = locationNotificationDTO.subtitle
        
        let localStorageService = LocalStorageService()
        localStorageService.loadImageFromDocumentsDirectory(imagePath: locationNotificationDTO.imagePath) { [weak self] image in
            DispatchQueue.main.async {
                self?.locationImageView.image = image
            }
        }
    }
    
    func setupUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(button)
        containerView.addSubview(locationImageView)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(5.0)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(50.0)
            make.top.left.equalToSuperview().inset(16.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).inset(-8.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).inset(-8.0)
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(4.0)
            make.width.equalTo(18.0)
            make.top.right.equalToSuperview().inset(16.0)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).inset(-8.0)
            make.leading.trailing.bottom.equalToSuperview().inset(16.0)
        }
    }
}
