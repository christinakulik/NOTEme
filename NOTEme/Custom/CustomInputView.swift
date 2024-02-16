//
//  InputView.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import SnapKit

protocol CustomInputViewDelegate: AnyObject {
    func cancelDidTap()
    func selectDidTap()
}

class CustomInputView: UIView {

    private weak var textField: UITextField?
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.titleLabel?.font = .appBoldFont
        button.addTarget(self, action: #selector(selectButtonTapped), 
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .appBoldFont.withSize(15.0)
        button.addTarget(self, action: #selector(cancelButtonTapped), 
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
      
        return datePicker
    }()
    
    weak var delegate: CustomInputViewDelegate?
    
    init(_ datePickerMode: UIDatePicker.Mode) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 280))
        datePicker.datePickerMode = datePickerMode
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .appBlack
        
        addSubview(datePicker)
        addSubview(cancelButton)
        addSubview(selectButton)
      
    }
    
    private func setupConstraints() {
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).inset(45.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(20.0)
        }
      
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14.0)
            make.leading.equalToSuperview().inset(20.0)
            make.height.equalTo(17.0)
        }
        
        selectButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(14.0)
            make.height.equalTo(17.0)
        }
    }
    
    // Действия кнопок
    @objc private func cancelButtonTapped() {
        delegate?.cancelDidTap()
    }
    
    @objc private func selectButtonTapped() {
        delegate?.selectDidTap()
    }
}


