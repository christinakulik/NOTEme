//
//  TimerNotificationCell.swift
//  NOTEme
//
//  Created by Christina on 23.02.24.
//

import UIKit
import SnapKit
import Storage

final class TimerNotificationCell: UITableViewCell {
    
    var buttonDidTap: ((_ sender: UIButton) -> Void)?
    
    private var timer: Timer?
    private lazy var containerView: UIView = .plainViewWithShadow()
    private lazy var titleLabel: UILabel = .titleCellLable()
    private lazy var subTitleLabel: UILabel = .subTitleCellLabel()
    private lazy var timerLabel: UILabel = .largeLabel()
    private lazy var timerImageView: UIImageView = 
    UIImageView(image: .Home.timer)

    private lazy var button: UIButton = .editButton()
        .withAction(self, #selector(editDidTap))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
        timerLabel.text = "00:00:00"
    }
    
    func setup(_ type: any DTODescription) {
        guard let timerNotificationDTO = type as? TimerNotificationDTO else {
            return
        }
        titleLabel.text = timerNotificationDTO.title
        subTitleLabel.text = timerNotificationDTO.subtitle
        let currentTime = Date()
        let targetTime = timerNotificationDTO.targetTime
        updateTimerLabel(currentTime: currentTime, targetTime: targetTime)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            [weak self] timer in
            self?.updateTimerLabel(currentTime: Date(), targetTime: targetTime)
        }
    }

    private func updateTimerLabel(currentTime: Date, targetTime: Date) {
        let timeDifference = Int(targetTime.timeIntervalSince(currentTime))
        if timeDifference >= 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            let timeString = 
            formatter.string(from: Date(timeIntervalSinceReferenceDate: TimeInterval(timeDifference)))
            self.timerLabel.text = timeString
        } else {
            timer?.invalidate()
            self.timerLabel.text = "00:00:00"
        }
    }

    
    @objc private func editDidTap(sender: UIButton) {
        buttonDidTap?(sender)
    }
    
    func setupUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(timerLabel)
        containerView.addSubview(timerImageView)
        containerView.addSubview(button)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(5.0)
            make.bottom.equalToSuperview().inset(5.0)
        }
    
        timerImageView.snp.makeConstraints { make in
            make.size.equalTo(50.0)
            make.top.left.equalToSuperview().inset(16.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(timerImageView.snp.trailing).inset(-8.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(timerImageView.snp.trailing).inset(-8.0)
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(4.0)
            make.width.equalTo(18.0)
            make.top.right.equalToSuperview().inset(16.0)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16.0)
            make.centerX.equalToSuperview()
        }
    }
}
