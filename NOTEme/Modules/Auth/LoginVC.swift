//
//  LoginVC.swift
//  NoteMe
//
//  Created by Christina on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    private lazy var logoImageView: UIImageView =
        UIImageView(image: .General.logo)
    
    private lazy var authTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .appTitleLabelBoldFont
        label.text = "Welcome back!"
        label.textColor = .black
        return label
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow()
        return view
    }()
    
    private lazy var passwordButton: UIButton = {
       let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .appButtonBoldFont
        button.addUnderline()
        return button
    }()
        
    private lazy var loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .appBoldFont
        button.setYellowButtonStyle()
        button.backgroundColor = .appYellow
        return button
    }()
    
    private lazy var registerButton: UIButton = {
       let button = UIButton()
        button.setTitle("New Account", for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.titleLabel?.font = .appBoldFont
        button.addUnderline()
        return button
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
        view.addSubview(registerButton)
       
        contentView.addSubview(logoImageView)
        contentView.addSubview(authTitleLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(loginButton)
        
        infoView.addSubview(passwordButton)
        
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
            make.top.equalTo(logoImageView.snp.bottom).inset(-72.0)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(authTitleLabel.snp.bottom).inset(-8.0)
            make.height.equalTo(165.0)
        }
        
        passwordButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(108.0)
            make.height.equalTo(20.0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(registerButton.snp.top).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
    }
}
