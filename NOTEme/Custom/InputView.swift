//
//  InputView.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import SnapKit

class CustomInputView: UIInputView {
    
    enum Mode {
        case date
        case timer
    }
    
    private let datePicker: UIDatePicker
    private let timerPicker: UIDatePicker
    private weak var textField: UITextField?
    
    private lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.titleLabel?.font = .appBoldFont
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .appBoldFont
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private(set) var mode: Mode = .date
    
    var onSelectButtonTapped: (() -> Void)?
    var onCancelButtonTapped: (() -> Void)?
    
    init() {
        datePicker = UIDatePicker()
        timerPicker = UIDatePicker()
        //        datePicker.datePickerMode = .wheels
        super.init(frame: .zero, inputViewStyle: .keyboard)
        
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настраиваем датапикер в соответствии с режимом и колбэком
//    private func configurePicker() {
//        switch mode {
//        case .date:
//            datePicker.datePickerMode = .date
//            datePicker.isHidden = false
//            timerPicker.isHidden = true
//        case .timer:
//            timerPicker.title = L10n.timerTextFieldTitle
//            timerPicker.placeholder = L10n.timerPlaceholderTextField
//            timerPicker.delegate = self // Делаем inputView делегатом timerTextField, чтобы получать события изменения текста
//            datePicker.isHidden = true
//            timerPicker.isHidden = false
//        }
//    }
    
    private func setupUI() {
        backgroundColor = .appBlack
        
        addSubview(datePicker)
        addSubview(timerPicker)
        addSubview(cancelButton)
        addSubview(selectButton)
      
    }
    
    private func setupConstraints() {
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).inset(-14.0)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        timerPicker.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).inset(-14.0)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14.0)
            make.leading.equalToSuperview().inset(20.0)
        }
        
        selectButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(14.0)
        }
    }
    
    // Действия кнопок
    @objc private func cancelButtonTapped() {
        onCancelButtonTapped?()
        textField?.resignFirstResponder()
    }
    
    @objc private func selectButtonTapped() {
        switch mode {
        case .date:
            onSelectButtonTapped?()
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            textField?.text = dateFormatter.string(from: datePicker.date)
        case .timer:
            // Текст таймера уже установлен в timerTextField, просто вызываем колбэк с ним
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
        }
        
        textField?.resignFirstResponder()
    }
}

// Расширяем inputView, чтобы он мог быть делегатом timerTextField
extension CustomInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Проверяем, что текстовое поле является timerTextField
        guard textField == timerPicker else { return true }
        
        // Получаем текущий и новый текст таймера
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Проверяем, что новый текст соответствует формату HH:mm:ss
        let regex = "^\\d{0,2}(:\\d{0,2}){0,2}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: newText)
    }
}


