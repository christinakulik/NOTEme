//
//  DateNotificationVC.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import SnapKit
import Storage

@objc protocol DateNotificationViewModelProtocol: AnyObject {
    
    var catchTitleError: ((String?) -> Void)? { get set }
    var catchDateError: ((String?) -> Void)? { get set }
    var title: String? { get set }
    var comment: String? { get set }
    var date: Date? { get set }
    func string(from date: Date) -> String?
    func date(from string: String) -> Date?
    func createDidTap()
    @objc func cancelDidTap()
    func loadDTOToEdit()
}

final class DateNotificationVC: UIViewController {
    
    private enum L10n {
        static let titleLabel: String =
        "createDate_titleLabel".localized
        static let createButton: String =
        "createDate_createButton".localized
        static let cancelButton: String =
        "createDate_cancelButton".localized
        static let titleTextField: String =
        "createDate_title".localized
        static let titlePlaceholderTextField: String =
        "createDate_titlePlaceholder".localized
        static let dateTextFieldTitle: String =
        "createDate_date".localized
        static let datePlaceholderTextField: String =
        "createDate_datePlaceholder".localized
        static let commentTextFieldTitle: String =
        "createDate_comment".localized
        static let commentPlaceholderTextField: String =
        "createDate_commentPlaceholder".localized
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
                    #selector(DateNotificationViewModelProtocol.cancelDidTap))
    
    private lazy var titleTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.titleTextField
        textField.delegate = self
        textField.placeholder = L10n.titlePlaceholderTextField
        return textField
    }()
    
    private lazy var dateTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = L10n.dateTextFieldTitle
        textField.delegate = self
        textField.placeholder = L10n.datePlaceholderTextField
        return textField
    }()
    
    private lazy var commentTextView: LineTextView = {
        let textView = LineTextView()
        textView.title = L10n.commentTextFieldTitle
        textView.delegate = self
        textView.placeholder = L10n.commentPlaceholderTextField
        return textView
    }()
    
    private var viewModel: DateNotificationViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: DateNotificationViewModelProtocol) {
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
        
        bind()
        viewModel.loadDTOToEdit()
        
        titleTextField.text = viewModel.title
        if let date = viewModel.date {
            dateTextField.text = viewModel.string(from: date)
        } else {
            dateTextField.text = nil
        }
        commentTextView.text = viewModel.comment
    }
    
    // MARK: - Private Methods
    private func bind() {
        viewModel.catchDateError = { [weak self] error in
            self?.dateTextField.errorText = error
        }
        
        viewModel.catchTitleError = { [weak self] error in
            self?.titleTextField.errorText = error
        }
    }

    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(cancelButton)
        view.addSubview(createButton)
        
        contentView.addSubview(infoView)
        contentView.addSubview(titleLabel)
        
        infoView.addSubview(titleTextField)
        infoView.addSubview(dateTextField)
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
            make.bottom.equalTo(commentTextView.snp.bottom).offset(16.0)
           
        }
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).inset(-16.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.bottom.equalTo(infoView.snp.bottom).inset(16.0)
            
        }
        
    }
    
    private func setupCustomInputView() {
        let datePicker = CustomInputView(.date)
        datePicker.delegate = self
        dateTextField.customInputView = datePicker
    }
    
    @objc private func createDidTap() {
        viewModel.createDidTap()
    }
    
}

// MARK: - Extensions
extension DateNotificationVC: LineTextFieldDelegate {
    func lineTextField(_ textfield: LineTextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
        if textfield == titleTextField {
            viewModel.title = textfield.text
        }
        return true
    }
}

extension DateNotificationVC: LineTextViewDelegate {
    func lineTextView(_ textview: LineTextView,
                      shouldChangeTextIn range: NSRange,
                      replacementText text: String) -> Bool {
        if textview == commentTextView {
            viewModel.comment = textview.text
        }
        return true
    }
}

extension DateNotificationVC: CustomInputViewDelegate {
    func dateDidChange(date: Date?) {
        if let date {
            let dateString = viewModel.string(from: date)
            dateTextField.text = dateString
        }
    }
    
    
    func cancelDidTap() {
        dateTextField.text = nil
        view.endEditing(true)
    }
    
    func selectDidTap() {
        if let dateString = dateTextField.text,
           let selectedDate = viewModel.date(from: dateString) {
            viewModel.date = selectedDate
        }
        view.endEditing(true)
    }
}


