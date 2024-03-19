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
    
    private enum L10n {
        static let titleLabel: String =
        "onbordSecondStep_screen_types_label".localized
        static let doneButton: String =
        "onbordSecondStep_screen_done_button".localized
        static let calendarLabel: String =
        "onbordSecondStep_screen_calendar_label".localized
        static let locationLabel: String =
        "onbordSecondStep_screen_location_label".localized
        static let timerLabel: String =
        "onbordSecondStep_screen_timer_label".localized
    }
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var typesImageView: UIImageView =
    UIImageView(image: .Onboarding.step)
    
    private lazy var typesTitleLabel: UILabel =
        .titleLabel(L10n.titleLabel)
    
    private lazy var infoView: UIView = .plainViewWithShadow()
    
    private var infoSecondStepLabel: UILabel = .infoLabelAttributes()
        
    private lazy var calendarLabel: UILabel =
        .selectionLabel(L10n.calendarLabel)
    
    private lazy var locationLabel: UILabel =
        .selectionLabel(L10n.locationLabel)
    
    private lazy var timerLabel: UILabel =
        .selectionLabel(L10n.timerLabel)
    
    private lazy var doneButton: UIButton = 
        .yellowRoundedButton(L10n.doneButton)
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
        setupUI()
        setupConstaits()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.dismissedByUser()
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
            make.bottom.equalTo(infoSecondStepLabel.snp.bottom)
           
        }
        
        infoSecondStepLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
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
