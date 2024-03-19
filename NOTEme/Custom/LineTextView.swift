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
            // Обновите текст и цвет textView в соответствии с placeholder
            if let placeholder = placeholder, textView.text.isEmpty {
                textView.text = placeholder
                textView.textColor = .lightGray
            } else {
                textView.text = nil
                textView.textColor = .appText
            }
        }
    }
    
    weak var delegate: LineTextViewDelegate?
    
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
            make.top.equalTo(textView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
            make.bottom.equalToSuperview()
        }
        
        topSeparator.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        rightSeparator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.bottom.equalTo(textView.snp.bottom)
            make.width.equalTo(1.0)
            make.trailing.equalToSuperview()
        }
        
        leftSeparator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.bottom.equalTo(textView.snp.bottom)
            make.width.equalTo(1.0)
            make.leading.equalToSuperview()
        }
    }
    
    // В методе textViewDidBeginEditing проверьте, содержит ли textView текст-заполнитель, и очистите его, если да
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .appText
        }
    }

    // В методе textViewDidEndEditing проверьте, пустой ли textView, и добавьте текст-заполнитель, если да
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
}

extension LineTextView: UITextViewDelegate {
    func textView(_ textView: UITextView,
                       shouldChangeTextIn range: NSRange,
                       replacementText text: String) -> Bool {
        if textView.text == placeholder && !text.isEmpty {
            return false
        } else {
            return delegate?.lineTextView?(self,
                                            shouldChangeTextIn: range,
                                            replacementText: text) ?? true
        }
    }
}
