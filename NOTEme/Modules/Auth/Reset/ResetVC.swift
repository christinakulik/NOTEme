//
//  ResetPasswordVC.swift
//  NOTEme
//
//  Created by Christina on 7.11.23.
//

import UIKit
import SnapKit

@objc protocol ResetViewModelProtocol: AnyObject {
    var catchEmailError: ((String?) -> Void)? { get set }
    
    func resetDidTap(email: String?)
    @objc func cancelDidTap()
}

final class ResetVC: UIViewController {
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var resetTitleLabel: UILabel =
        .titleLabel("reset_screen_resetPassword_label".localized)
    
    private lazy var infoView: UIView = .plainViewWithShadow()

    private lazy var resetButton: UIButton =
        .yellowRoundedButton("reset_screen_reset_button".localized)
        .withAction(self, #selector(resetDidTap))
    private lazy var cancelButton: UIButton = .cancelButton()
        .withAction(viewModel, 
                    #selector(ResetViewModelProtocol.cancelDidTap))
    private lazy var infoResetPasswordLabel: UILabel =
        .infoLabel("reset_screen_infoReset_label".localized)
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.placeholder = "reset_screen_email_placeholder".localized
        return textField
    }()
    
    private var viewModel: ResetViewModelProtocol
    
    init(viewModel: ResetViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    
    private func bind() {
        viewModel.catchEmailError = { errorText in
            self.emailTextField.errorText = errorText
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        view.addSubview(contentView)
    }
    
    private func setupUI() {
    
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(cancelButton)
       
        contentView.addSubview(resetTitleLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(resetButton)
        contentView.addSubview(logoContainer)
        
        logoContainer.addSubview(logoImageView)
       
        infoView.addSubview(emailTextField)
        infoView.addSubview(infoResetPasswordLabel)
        
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(resetButton.snp.centerY)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(resetTitleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        resetTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
           
        }
        
        infoResetPasswordLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
            make.bottom.equalTo(emailTextField.snp.top).inset(-8)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        resetButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
    }
    
    @objc private func resetDidTap() {
        viewModel.resetDidTap(email: emailTextField.text)
    }
}

