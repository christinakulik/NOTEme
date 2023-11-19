//
//  LoginVC.swift
//  NoteMe
//
//  Created by Christina on 24.10.23.
//

import UIKit
import SnapKit

@objc protocol LoginViewModelProtocol: AnyObject {
    var catchEmailError: ((String?) -> Void)? { get set }
    var catchPasswordError: ((String?) -> Void)? { get set }
    
    func loginDidTap(email: String?, password: String?)
    @objc func newAccountDidTap()
    func forgotPasswordDidTap(email: String?)
}

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var authTitleLabel: UILabel = 
        .titleLabel("login_screen_welcome_label".localized)
    
    private lazy var infoView: UIView = .plainViewWithShadow()

    private lazy var loginButton: UIButton = 
        .yellowRoundedButton("login_screen_login_button".localized)
        .withAction(self, #selector(loginDidTap))
    private lazy var newAccountButton: UIButton = .underlineYellowButton("login_screen_newAccount_button".localized)
        .withAction(viewModel,
                    #selector(LoginViewModelProtocol.newAccountDidTap))
    private lazy var forgotPasswordButton: UIButton = .underlineGrayButton("login_screen_forgotPassword_button".localized)
        .withAction(self, #selector(forgotPasswordDidTap))
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "login_screen_titleEmail_label".localized
        textField.placeholder = "login_screen_email_placeholder".localized
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "login_screen_titlePassword_label".localized
        textField.placeholder = "login_screen_password_placeholder".localized
        return textField
    }()
    
    private var viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
    }
    
    private func bind() {
        viewModel.catchEmailError = { errorText in
            self.emailTextField.errorText = errorText
        }
        
        viewModel.catchPasswordError = {
            self.passwordTextField.errorText = $0
        }
    }
    
    private func setupUI() {
    
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(newAccountButton)
        view.addSubview(loginButton)
     
        contentView.addSubview(infoView)
        contentView.addSubview(authTitleLabel)
        contentView.addSubview(logoContainer)
        
        logoContainer.addSubview(logoImageView)
        
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
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(authTitleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
        
    }
    
    @objc private func loginDidTap() {
        viewModel.loginDidTap(email: emailTextField.text,
                              password: passwordTextField.text)
    }
    
    @objc private func forgotPasswordDidTap() {
        viewModel.forgotPasswordDidTap(email: emailTextField.text)
    }
}
