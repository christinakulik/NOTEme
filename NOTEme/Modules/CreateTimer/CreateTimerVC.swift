//
//  CreateTimerVC.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import SnapKit

@objc protocol CreateTimerViewModelProtocol: AnyObject {
    
    func createDidTap(title: String?, comment: String?, date: String?)
    @objc func cancelDidTap()
}

final class CreateTimerVC: UIViewController {
    
    private enum L10n {
        static let titleLabel: String =
        "createTimer_titleLabel".localized
        static let createButton: String =
        "createTimer_createButton".localized
        static let cancelButton: String =
        "createTimer_cancelButton".localized
        static let titleTextField: String =
        "createTimer_title".localized
        static let titlePlaceholderTextField: String =
        "createTimer_titlePlaceholder".localized
        static let timerTextFieldTitle: String =
        "createTimer_timer".localized
        static let timerPlaceholderTextField: String =
        "createTimer_timerPlaceholder".localized
        static let commentTextFieldTitle: String =
        "createTimer_comment".localized
        static let commentPlaceholderTextField: String =
        "createTimer_commentPlaceholder".localized
    }
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var titleLabel: UILabel =
        .dataBoldLabel(L10n.titleLabel)
    
    private lazy var infoView: UIView = .plainViewWithShadow()

    private lazy var createButton: UIButton =
        .yellowRoundedButton(L10n.createButton)
        .withAction(self, #selector(createDidTap))
   
    private lazy var cancelButton: UIButton =
        .cancelButton()
        .withAction(viewModel,
                    #selector(CreateTimerViewModelProtocol.cancelDidTap))
    
    private lazy var titleTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.titleTextField
        textField.placeholder = L10n.titlePlaceholderTextField
        return textField
    }()
    
    private lazy var timerTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.timerTextFieldTitle
        textField.placeholder = L10n.timerPlaceholderTextField
        textField.customInputView = CustomInputView()
        return textField
    }()
    
    private lazy var commentTextView: LineTextView = {
        let textView = LineTextView()
        textView.title = L10n.commentTextFieldTitle
        textView.placeholder = L10n.commentPlaceholderTextField
        return textView
    }()
    
    private var viewModel: CreateTimerViewModelProtocol
    
    init(viewModel: CreateTimerViewModelProtocol) {
        self.viewModel = viewModel
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
        view.addSubview(cancelButton)
        view.addSubview(createButton)
     
        contentView.addSubview(infoView)
        contentView.addSubview(titleLabel)
        
        infoView.addSubview(titleTextField)
        infoView.addSubview(timerTextField)
        infoView.addSubview(commentTextView)
        
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(createButton.snp.centerY)
        }

        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }

        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20.0)
            make.leading.equalTo(20.0)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.height.equalTo(250.0)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.top).offset(16.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        timerTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(timerTextField.snp.bottom).offset(16.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.bottom.lessThanOrEqualToSuperview().inset(16.0)
        }

    }
    
    @objc private func createDidTap() {
        viewModel.createDidTap(title: titleTextField.text,
                               comment: commentTextView.text,
                               date: timerTextField.text)
    }
    
    @objc private func cancelDidTap() {
        viewModel.createDidTap(title: titleTextField.text,
                               comment: commentTextView.text,
                               date: timerTextField.text)
    }
   
}

extension CreateTimerVC: UITextViewDelegate {
    private func textFieldDidBeginEditing(_ textField: UITextField) {
                let customInputView = CustomInputView()
                customInputView.onSelectButtonTapped = { [weak self] in
                    // Обработка нажатия кнопки "Select"
                    self?.createDidTap()
                }
                customInputView.onCancelButtonTapped = { [weak self] in
                    // Обработка нажатия кнопки "Cancel"
                    self?.cancelDidTap()
                }
                textField.inputView = customInputView
            }
}
