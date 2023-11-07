//
//  RegisterVC.swift
//  NOTEme
//
//  Created by Christina on 7.11.23.
//

import UIKit
import SnapKit

final class RegisterVC: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var titleLabel: UILabel =
        .titleLabel("niceToMeet_label".localized)
    
    private lazy var infoView: UIView = .plainView()

    private lazy var registerButton: UIButton =
        .yellowRoundedButton("register_button".localized)
    private lazy var accountButton: UIButton =
        .underlineYellowButton("haveAnAccount_button".localized)
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "titleEmail_label".localized
        textField.placeholder = "email_placeholder".localized
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "titlePassword_label".localized
        textField.placeholder = "password_placeholder".localized
        return textField
    }()
    
    private lazy var repeatPasswordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "repeatPassword_label".localized
        textField.placeholder = "repeatPassword_placeholder".localized
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        view.addSubview(contentView)
    }
    
    private func setupUI() {
    
        view.backgroundColor = .appBlack
        
        view.addSubview(contentView)
        view.addSubview(accountButton)
       
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(registerButton)
        
        infoView.addSubview(repeatPasswordTextField)
        infoView.addSubview(emailTextField)
        infoView.addSubview(passwordTextField)
        
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(registerButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
           
        }
        
        accountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(20.0)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(accountButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-16.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(repeatPasswordTextField.snp.top).inset(-16)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
    }
}
