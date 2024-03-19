//
//  LocationNotificationVC.swift
//  NOTEme
//
//  Created by Christina on 5.03.24.
//

import UIKit
import SnapKit
import Storage

protocol LocationNotificationViewModelProtocol: AnyObject {
    var title: String? { get set }
    var comment: String? { get set }
    var imageDidSet: ((UIImage?) -> Void)? { get set }
    var shouldEditDTO: ((LocationNotificationDTO) -> Void)? { get set }
    func createDidTap()
    func cancelDidTap()
    func viewDidLoad()
    func locationImageDidTap()
}

final class LocationNotificationVC: UIViewController {
    
    private enum L10n {
        static let titleLabel: String =
        "createLocation_titleLabel".localized
        static let createButton: String =
        "createLocation_createButton".localized
        static let cancelButton: String =
        "createLocation_cancelButton".localized
        static let titleTextField: String =
        "createLocation_title".localized
        static let titlePlaceholderTextField: String =
        "createLocation_titlePlaceholder".localized
        static let commentTextFieldTitle: String =
        "createLocation_comment".localized
        static let commentPlaceholderTextField: String =
        "createLocation_commentPlaceholder".localized
        static let locationLabel: String =
        "createLocation_location".localized
        
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
    
    private lazy var commentTextView: LineTextView = {
        let textView = LineTextView()
        textView.title = L10n.commentTextFieldTitle
        textView.delegate = self
        textView.placeholder = L10n.commentPlaceholderTextField
        return textView
    }()
   
    private lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.font = .appBoldFont.withSize(13.0)
        label.textColor = .appText
        label.text = L10n.locationLabel
        return label
    }()
    
    private lazy var locationImageView: UIImageView =
    UIImageView(image: .Location.defaultLocationImage)
    
    private var viewModel: LocationNotificationViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: LocationNotificationViewModelProtocol) {
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
        bind()
        addTapGestureToLocationImage()
        
        titleTextField.text = viewModel.title
        commentTextView.text = viewModel.comment
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func bind() {
        viewModel.imageDidSet = { [weak locationImageView] image in
            locationImageView?.image = image
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
        infoView.addSubview(locationLabel)
        infoView.addSubview(commentTextView)
        infoView.addSubview(locationImageView)
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
            make.bottom.equalTo(locationImageView.snp.bottom).offset(16.0)
           
        }
        
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(commentTextView.snp.bottom).inset(-16.0)
            make.leading.equalToSuperview().inset(16.0)
            
        }
        
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).inset(-8.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.bottom.equalTo(infoView.snp.bottom).inset(16.0)
            make.height.equalTo(147.0)
        }
    }
    
    @objc private func createDidTap() {
        viewModel.createDidTap()
    }
    
    private func addTapGestureToLocationImage() {
        let tapGesture =
        UITapGestureRecognizer(target: self,
                               action: #selector(locationImageDidTap))
        locationImageView.isUserInteractionEnabled = true
        locationImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func locationImageDidTap(_ gesture: UITapGestureRecognizer) {
        viewModel.locationImageDidTap()
    }
}

// MARK: - Extensions
extension LocationNotificationVC: LineTextFieldDelegate {
    func lineTextField(_ textfield: LineTextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
        if textfield == titleTextField {
            viewModel.title = textfield.text
        }
        return true
    }
}

extension LocationNotificationVC: LineTextViewDelegate {
    func lineTextView(_ textview: LineTextView,
                      shouldChangeTextIn range: NSRange,
                      replacementText text: String) -> Bool {
        if textview == commentTextView {
            viewModel.comment = textview.text
        }
        return true
    }
}

