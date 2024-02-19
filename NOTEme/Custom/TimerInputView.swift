//
//  TimerInputView.swift
//  NOTEme
//
//  Created by Christina on 18.02.24.
//
import UIKit
import SnapKit

final class TimerInputView: UIView {

    private weak var textField: UITextField?

    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.titleLabel?.font = .appBoldFont
        button.addTarget(self, action: #selector(selectButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .appBoldFont.withSize(15.0)
        button.addTarget(self, action: #selector(cancelButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private lazy var timerPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    weak var delegate: CustomInputViewDelegate?

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 280))
        setupUI()
        setupConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .appBlack

        addSubview(timerPicker)
        addSubview(cancelButton)
        addSubview(selectButton)

    }

    private func setupConstraints() {
        timerPicker.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(20.0)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14.0)
            make.leading.equalToSuperview().inset(20.0)
            make.height.equalTo(17.0)
        }

        selectButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(14.0)
            make.height.equalTo(17.0)
        }
    }
    
    private func createDateFromComponents(hours: Int, 
                                          minutes: Int,
                                          seconds: Int) -> Date? {
           let calendar = Calendar.current
           var dateComponents = DateComponents()
           dateComponents.hour = hours
           dateComponents.minute = minutes
           dateComponents.second = seconds
           
           return calendar.date(from: dateComponents)
       }

    // Button Actions
    @objc private func cancelButtonTapped() {
        delegate?.cancelDidTap()
    }

    @objc private func selectButtonTapped() {
        delegate?.selectDidTap()
    }
    
    @objc func dateDidChange() {
           let selectedHours = timerPicker.selectedRow(inComponent: 0)
           let selectedMinutes = timerPicker.selectedRow(inComponent: 1)
           let selectedSeconds = timerPicker.selectedRow(inComponent: 2)
           
           let date = createDateFromComponents(hours: selectedHours, 
                                               minutes: selectedMinutes,
                                               seconds: selectedSeconds)
           
           delegate?.dateDidChange(date: date)
       }

}

extension TimerInputView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // Часы, минуты, секунды
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        } else {
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, 
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        var title = ""
        var attributes: [NSAttributedString.Key : Any] = [:]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = 
        (component == 0) ? .right : (component == 2) ? .left : .center
        
        switch component {
        case 0:
            title = "\(row) hours"
        case 1:
            title = "\(row) min"
        case 2:
            title = "\(row) sec"
        default:
            break
        }
        
        attributes[.font] = UIFont.appFont.withSize(16.0)
        attributes[.foregroundColor] = UIColor.black
        attributes[.paragraphStyle] = paragraphStyle
        
        let attributedString = NSAttributedString(string: title, 
                                                  attributes: attributes)
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, 
                    didSelectRow row: Int,
                    inComponent component: Int) {
            //метод dateDidChange при изменении значений в UIPickerView
            dateDidChange()
        }
}
