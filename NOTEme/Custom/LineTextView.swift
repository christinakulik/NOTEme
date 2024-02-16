//
//  LineTextView.swift
//  NOTEme
//
//  Created by Christina on 10.02.24.
//

import UIKit
import SnapKit

@objc protocol LineTextViewDelegate: AnyObject {
    @objc optional func lineTextView(_ textview: LineTextView,
                   shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool
}


class LineTextView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .appText
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .appText
        textView.isScrollEnabled = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .appText
        return view
    }()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .appText
        return view
    }()
    
    private lazy var rightSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .appText
        return view
    }()
    
    private lazy var leftSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .appText
        return view
    }()
    
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var text: String? {
        get { textView.text }
        set { textView.text = newValue }
    }
    
    
    var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                if textView.text.isEmpty {
                    let attributes: [NSAttributedString.Key: Any] =
                    [.foregroundColor: UIColor.appGrayText,
                     .font: UIFont.appFont.withSize(15.0)]
                    textView.attributedText =
                    NSAttributedString(string: placeholder,
                                       attributes: attributes)
                }
            } else {
                textView.attributedText = nil
            }
        }
    }
    
    weak var delegate: LineTextViewDelegate?
    
//    func textViewDidChange(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            let attributes: [NSAttributedString.Key: Any] =
//            [.foregroundColor: UIColor.gray,
//             .font: UIFont.systemFont(ofSize: 14)]
//            textView.attributedText =
//            NSAttributedString(string: placeholder ?? "",
//                               attributes: attributes)
//        } else if textView.attributedText.string == placeholder {
//            textView.attributedText = nil
//        }
//    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
        let attributes: [NSAttributedString.Key: Any] =
        [.foregroundColor: UIColor.appText]
        textView.typingAttributes = attributes
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(bottomSeparator)
        addSubview(topSeparator)
        addSubview(rightSeparator)
        addSubview(leftSeparator)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(68.0)
        }
        
        bottomSeparator.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        topSeparator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        rightSeparator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.bottom.equalTo(textView.snp.bottom).inset(-4.0)
            make.width.equalTo(1.0)
            make.trailing.equalToSuperview()
        }
        
        leftSeparator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.bottom.equalTo(textView.snp.bottom).inset(-4.0)
            make.width.equalTo(1.0)
            make.leading.equalToSuperview()
        }
    }
}

extension LineTextView: UITextViewDelegate {
    func textView(_ textView: UITextView,
                   shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        return delegate?.lineTextView?(self,
                                        shouldChangeTextIn: range,
                                        replacementText: text) ?? true
    }
}
