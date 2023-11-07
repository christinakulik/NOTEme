//
//  LineTextField.swift
//  NOTEme
//
//  Created by Christina on 31.10.23.
//

import UIKit
import SnapKit

final class LineTextField: UIView {
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .appBoldFont.withSize(13.0)
        label.textColor = .appText
        label.textAlignment = .left
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .appFont.withSize(15.0)
        textField.textColor = .appText
        textField.textAlignment = .left
        return textField
    }()
    
    private lazy var separator: UIView = {
        
        let view = UIView()
        view.backgroundColor = .appText
        return view
        
    }()
    
    private lazy var errorLabel: UILabel = {
       let label = UILabel()
        label.font = .appBoldFont.withSize(12.0)
        label.textColor = .appRed
        label.textAlignment = .left
        return label
    }()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var errorText: String? {
        get { errorLabel.text }
        set { errorLabel.text = newValue }
    }
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
        
    }
    
    var text: String? {
            get { textField.text }
            set { textField.text = newValue }
    }
    
    var delagate: UITextFieldDelegate? {
        get { textField.delegate }
        set { textField.delegate = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(separator)
        addSubview(errorLabel)
    }
   
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(separator.snp.bottom).inset(-4.0)
        }
    }
}
