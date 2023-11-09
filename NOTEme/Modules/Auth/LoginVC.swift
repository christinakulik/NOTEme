//
//  LoginVC.swift
//  NoteMe
//
//  Created by Christina on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var authTitleLabel: UILabel = 
        .titleLabel("welcome_label".localized)
    
    private lazy var infoView: UIView = .plainView()

    private lazy var loginButton: UIButton = 
        .yellowRoundedButton("login_button".localized)
    private lazy var newAccountButton: UIButton = .underlineYellowButton("newAccount_button".localized)
    private lazy var forgotPasswordButton: UIButton = .underlineGrayButton("forgotPassword_button".localized)
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        view.addSubview(contentView)
    }
    
    private func setupUI() {
    
        view.backgroundColor = .appBlack
        
        view.addSubview(contentView)
        view.addSubview(newAccountButton)
       
        contentView.addSubview(logoImageView)
        contentView.addSubview(authTitleLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(loginButton)
        
        infoView.addSubview(forgotPasswordButton)
        infoView.addSubview(emailTextField)
        infoView.addSubview(passwordTextField)
        
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(loginButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        authTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
           
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(16.0)
            make.height.equalTo(17.0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-16.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(forgotPasswordButton.snp.top).inset(-20)
        }
        
        newAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(20.0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(newAccountButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
    }
}
