//
//  CreateTimerVC.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import SnapKit

protocol CreateTimerViewModelProtocol: AnyObject {
    
    var title: String? { get set }
    var comment: String? { get set }
    var duration: TimeInterval? { get set }
    func createDidTap()
    func cancelDidTap()
    func string(from date: Date) -> String?
    func date(from string: String) -> Date?
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
        .withAction(self, #selector(revokeDidTap))
    
    private lazy var titleTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.titleTextField
        textField.delegate = self
        textField.placeholder = L10n.titlePlaceholderTextField
        return textField
    }()
    
    private lazy var timerTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.timerTextFieldTitle
        textField.placeholder = L10n.timerPlaceholderTextField
        return textField
    }()
    
    private lazy var commentTextView: LineTextView = {
        let textView = LineTextView()
        textView.title = L10n.commentTextFieldTitle
        textView.delegate = self
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
        setupCustomInputView()
       
    }
  
//MARK: - UI
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
    
//MARK: - Private Methods
    private func setupCustomInputView() {
        let datePicker = CustomInputView(.countDownTimer)
        datePicker.delegate = self
        timerTextField.customInputView = datePicker
    }
    
    @objc private func createDidTap() {
        viewModel.createDidTap()
    }
    @objc private func revokeDidTap() {
        viewModel.cancelDidTap()
    }
   
}
//MARK: - Delegates
extension CreateTimerVC: LineTextFieldDelegate {
    func lineTextField(_ textfield: LineTextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
        if textfield == titleTextField {
            viewModel.title = textfield.text
        } else if textfield == timerTextField {
            if let dateString = textfield.text, 
                let duration = viewModel.date(from: dateString) {
                viewModel.duration =
                duration.timeIntervalSince1970 - Date().timeIntervalSince1970
            } else {
                viewModel.duration = nil
            }
        }
        return true
    }
}

extension CreateTimerVC: LineTextViewDelegate {
    func lineTextView(_ textview: LineTextView,
                      shouldChangeTextIn range: NSRange,
                      replacementText text: String) -> Bool {
        if textview == commentTextView {
            viewModel.comment = textview.text
        } else {
            viewModel.comment = nil
        }
        return true
    }
}

extension CreateTimerVC: CustomInputViewDelegate {
    func cancelDidTap() {
        view.endEditing(true)
      
    }
    
    func selectDidTap() {
        if timerTextField.text == "" {
            let time = viewModel.string(from: Date())
            timerTextField.text = time
        }
        view.endEditing(true)
    }
}
