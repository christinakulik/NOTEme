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

protocol RegisterKeyboardAnimatorUseCase {
    func move(for targetView: UIView,
              frame: CGRect,
              with padding: CGFloat)
}

final class RegisterVC: UIViewController {
    
    private enum L10n {
        static let titleLabel: String =
        "register_screen_register_label".localized
        static let registerButton: String =
        "register_screen_register_button".localized
        static let haveAccountButton: String =
        "register_screen_haveAccount_button".localized
        static let emailTextFieldTitle: String =
        "register_screen_email_label".localized
        static let emailTextFieldPlaceholder: String =
        "register_screen_email_placeholder".localized
        static let passwordTextFieldTitle: String =
        "register_screen_password_label".localized
        static let passwordTextFieldPlaceholder: String =
        "register_screen_password_placeholder".localized
        static let repeatPasswordTextFieldTitle: String =
        "register_screen_repeatPassword_label".localized
        static let repeatPasswordTextFieldPlaceholder: String =
        "register_screen_repeatPassword_placeholder".localized
    }
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var registerTitleLabel: UILabel =
        .titleLabel(L10n.titleLabel)
    
    private lazy var infoView: UIView = .plainViewWithShadow()

    private lazy var registerButton: UIButton =
        .yellowRoundedButton(L10n.registerButton)
        .withAction(self, #selector(registerDidTap))
    private lazy var haveAccountButton: UIButton =
        .underlineYellowButton(L10n.haveAccountButton)
        .withAction(presenter,
                    #selector(RegisterPresenterProtocol.haveAccountDidTap))
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.emailTextFieldTitle
        textField.placeholder = L10n.emailTextFieldPlaceholder
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.passwordTextFieldTitle
        textField.placeholder = L10n.passwordTextFieldPlaceholder
        return textField
    }()
    
    private lazy var repeatPasswordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.repeatPasswordTextFieldTitle
        textField.placeholder = L10n.repeatPasswordTextFieldPlaceholder
        return textField
    }()
    
    private var presenter: RegisterPresenterProtocol
    
    private var animate: RegisterKeyboardAnimatorUseCase
    
    init (presenter: RegisterPresenterProtocol,
          animate: RegisterKeyboardAnimatorUseCase) {
        self.presenter = presenter
        self.animate = animate
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
    
    func keyboardFrameChanged(_ frame: CGRect) {
        let padding = 16 + contentView.frame.minY
        animate.move(for: infoView, frame: frame, with: padding)
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
}
