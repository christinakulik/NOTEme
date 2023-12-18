//
//  OnbordFirstStepVC.swift
//  NOTEme
//
//  Created by Christina on 28.11.23.
//

import UIKit
import SnapKit

@objc protocol OnbordFirstStepViewModelProtocol {
    @objc func nextDidTap()
    
}

final class OnbordFirstStepVC: UIViewController {
    
    private enum L10n {
        static let titleLabel: String =
        "onbordFirstStep_screen_welcome_label".localized
        static let nextButton: String =
        "onbordFirstStep_screen_next_button".localized
        static let infoLabel: String =
        "onbordFirstStep_info_label".localized
    }
    
    private lazy var contentView: UIView = .basicView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var welcomeTitleLabel: UILabel =
        .titleLabel(L10n.titleLabel)
    
    private lazy var infoView: UIView = .plainViewWithShadow()
    
    private lazy var infoFirstStepLabel: UILabel =
        .infoLabel(L10n.infoLabel)
    
    private lazy var nextButton: UIButton =
        .yellowRoundedButton(L10n.nextButton)
        .withAction(viewModel,
                    #selector(OnbordFirstStepViewModelProtocol.nextDidTap))
    
    private var viewModel: OnbordFirstStepViewModelProtocol
    
    init(viewModel: OnbordFirstStepViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setupUI()
        setupConstaits()
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
       
        view.addSubview(contentView)
        view.addSubview(welcomeTitleLabel)
        view.addSubview(nextButton)
        
        contentView.addSubview(infoView)
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)

        infoView.addSubview(infoFirstStepLabel)
    }
   
    private func setupConstaits() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(nextButton.snp.centerY)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(welcomeTitleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        welcomeTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
           
        }
        
        infoFirstStepLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.bottom.equalToSuperview().inset(16.0)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
    }
}
