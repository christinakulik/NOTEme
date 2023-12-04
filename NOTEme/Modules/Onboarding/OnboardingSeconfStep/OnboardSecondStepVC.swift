//
//  OnboardSecondStepVC.swift
//  NOTEme
//
//  Created by Christina on 28.11.23.
//


import UIKit
import SnapKit

@objc protocol OnbordSecondStepViewModelProtocol {
    @objc func doneDidTap()
    func dismissedByUser()
}

final class OnboardSecondStepVC: UIViewController {
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var typesImageView: UIImageView =
    UIImageView(image: .Onboarding.step)
    
    private lazy var typesTitleLabel: UILabel =
        .titleLabel("onbordSecondStep_screen_types_label".localized)
    
    private lazy var infoView: UIView = .plainViewWithShadow()
    
    private lazy var infoSecondStepLabel: UILabel =
        .infoLabel("onbordSecondStep_screen_info_label".localized)
    
    private lazy var calendarLabel: UILabel =
        .selectionLabel("onbordSecondStep_screen_calendar_label".localized)
    
    private lazy var locationLabel: UILabel =
        .selectionLabel("onbordSecondStep_screen_location_label".localized)
    
    private lazy var timerLabel: UILabel =
        .selectionLabel("onbordSecondStep_screen_timer_label".localized)
    
    private lazy var doneButton: UIButton = 
        .yellowRoundedButton("onbordSecondStep_screen_done_button".localized)
        .withAction(viewModel, 
                    #selector(OnbordSecondStepViewModelProtocol.doneDidTap))
    
    private var viewModel: OnbordSecondStepViewModelProtocol
    
    init(viewModel: OnbordSecondStepViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupAttrubutes()
        setupUI()
        setupConstaits()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.dismissedByUser()
    }
    
    private func setupAttrubutes() {
        infoSecondStepLabel.attributedText = "onbordSecondStep_screen_info_label"
            .localized
            .changeFont()
        
//        let descriptionString = String(format: "onbordSecondStep_screen_info_label".localized)
//        let description = NSMutableAttributedString(string: descriptionString)
//        let rangeCalendar = descriptionString.range(of: "Calendar")
//        let rangeLocation = descriptionString.range(of: "Location")
//        let rangeTimer = descriptionString.range(of: "Timer")
//        let nsrangeCalendar = NSRange(rangeCalendar!, in: descriptionString)
//        let nsrangeLocation = NSRange(rangeLocation!, in: descriptionString)
//        let nsrangeTimer = NSRange(rangeTimer!, in: descriptionString)
//        description.addAttributes([NSAttributedString.Key.font: 
//                                    UIFont.appBoldFont.withSize(13.0)],
//                                  range: nsrangeCalendar)
//        description.addAttributes([NSAttributedString.Key.font: 
//                                    UIFont.appBoldFont.withSize(13.0)],
//                                  range: nsrangeLocation)
//        description.addAttributes([NSAttributedString.Key.font: 
//                                    UIFont.appBoldFont.withSize(13.0)],
//                                  range: nsrangeTimer)
//        
//        infoSecondStepLabel.attributedText = description
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
       
        view.addSubview(contentView)
        view.addSubview(typesTitleLabel)
        view.addSubview(doneButton)
        
        contentView.addSubview(infoView)
        contentView.addSubview(logoContainer)
        contentView.addSubview(typesImageView)
        
        logoContainer.addSubview(logoImageView)

        infoView.addSubview(infoSecondStepLabel)
        
        typesImageView.addSubview(calendarLabel)
        typesImageView.addSubview(locationLabel)
        typesImageView.addSubview(timerLabel)
        
    }
    
    
   
    private func setupConstaits() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(doneButton.snp.centerY)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(typesTitleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        typesTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
           
        }
        
        infoSecondStepLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.bottom.equalToSuperview().inset(16.0)
        }
        
        typesImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(doneButton.snp.top).inset(-62.0)
            make.width.equalTo(180.0)
            make.height.equalTo(157.0)
        }
        
        calendarLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22.0)
            make.left.equalToSuperview().inset(26.0)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarLabel.snp.bottom).inset(-17.0)
            make.left.equalToSuperview().inset(26.0)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).inset(-17.0)
            make.left.equalToSuperview().inset(26.0)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
    }
}
