//
//  RegisterVC.swift
//  NOTEme
//
//  Created by Christina on 7.11.23.
//

import UIKit
import SnapKit

@objc protocol RegisterPresenterProtocol: AnyObject {
    func registerDidTap(email: String?,
                        password: String?,
                        repeatPassword: String?)
    @objc  func haveAccountDidTap()
}

final class RegisterVC: UIViewController {
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var registerTitleLabel: UILabel =
        .titleLabel("register_screen_register_label".localized)
    
    private lazy var infoView: UIView = .plainViewWithShadow()

    private lazy var registerButton: UIButton =
        .yellowRoundedButton("register_screen_register_button".localized)
        .withAction(self, #selector(registerDidTap))
    private lazy var haveAccountButton: UIButton =
        .underlineYellowButton("register_screen_haveAccount_button".localized)
        .withAction(presenter,
                    #selector(RegisterPresenterProtocol.haveAccountDidTap))
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "register_screen_email_label".localized
        textField.placeholder = "register_screen_email_placeholder".localized
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "register_screen_password_label".localized
        textField.placeholder = 
        "register_screen_password_placeholder".localized
        return textField
    }()
    
    private lazy var repeatPasswordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "register_screen_repeatPassword_label".localized
        textField.placeholder = 
        "register_screen_repeatPassword_placeholder".localized
        return textField
    }()
    
    private var presenter: RegisterPresenterProtocol
    
    init (presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
    }
    
    private func setupUI() {
    
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(haveAccountButton)
        
        contentView.addSubview(logoContainer)
        contentView.addSubview(registerTitleLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(registerButton)
        
        logoContainer.addSubview(logoImageView)
        
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
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(registerTitleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        registerTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
           
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
            make.bottom.left.equalToSuperview().inset(20.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        haveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(20.0)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(haveAccountButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
    }
    
    
    @objc private func registerDidTap() {
        presenter.registerDidTap(email: emailTextField.text,
                                 password: passwordTextField.text,
                                 repeatPassword: repeatPasswordTextField.text)
    }
}

extension RegisterVC: RegisterPresenterDelegate {
    
    func setEmailError(error: String?) {
        emailTextField.errorText = error
    }
    
    func setPasswordError(error: String?) {
        passwordTextField.errorText = error
    }
    
    func setRepeatPasswordError(error: String?) {
        repeatPasswordTextField.errorText = error
    }
    
    func keyboardFrameChanged(_ frame: CGRect) {
        let maxY = infoView.frame.maxY + contentView.frame.minY + 16.0
        let keyboardY = frame.minY
        
        if maxY > keyboardY {
            let diff = maxY - keyboardY
            infoView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-diff)
            }
            self.view.layoutIfNeeded()
        }
    }
}


