//
//  DateNotificationCell.swift
//  NOTEme
//
//  Created by Christina on 23.02.24.
//

import UIKit
import SnapKit
import Storage

final class DateNotificationCell: UITableViewCell {
    
    var buttonDidTap: ((_ sender: UIButton) -> Void)?
    
    private lazy var titleLabel: UILabel = .titleCellLable()
    private lazy var subTitleLabel: UILabel = .subTitleCellLabel()
    private lazy var dayLabel: UILabel = .dayLabel()
    private lazy var monthLabel: UILabel = .monthLabel()
    
    private lazy var view: UIView = .blackView()
    private lazy var containerView: UIView = .plainViewWithShadow()
    
    private lazy var button: UIButton = .editButton()
        .withAction(self, #selector(editDidTap))
    
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
        guard let dateNotificationDTO = type as? DateNotificationDTO else {
            return
        }
        
        titleLabel.text = dateNotificationDTO.title
        subTitleLabel.text = dateNotificationDTO.subtitle
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dayLabel.text = 
        dateFormatter.string(from: dateNotificationDTO.targetDate)
        
        dateFormatter.dateFormat = "MMM"
        monthLabel.text = 
        dateFormatter.string(from: dateNotificationDTO.targetDate)
    }

    func setupUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(view)
        containerView.addSubview(button)
        
        view.addSubview(dayLabel)
        view.addSubview(monthLabel)
        
   
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10.0)
        }
        
        view.snp.makeConstraints { make in
            make.size.equalTo(50.0)
            make.top.left.equalToSuperview().inset(16.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.trailing).inset(-8.0)
            make.top.equalToSuperview().inset(16.0)
            make.trailing.equalTo(button.snp.leading)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.trailing).inset(-8.0)
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.trailing.equalTo(button.snp.leading)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(4.0)
            make.width.equalTo(18.0)
            make.top.equalToSuperview().inset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4.0)
            make.centerX.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).inset(3.0)
            make.centerX.equalToSuperview()
        }
    }
}
