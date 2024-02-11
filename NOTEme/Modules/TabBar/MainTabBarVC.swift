//
//  MainTabBarVC.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit
import SnapKit

protocol MainTabBarViewModelProtocol  {
    func addDidTap()
}

final class MainTabBarVC: UITabBarController {
    
    private lazy var addButton: UIButton = .addButton()
        .withAction(self, #selector(addDidTap))
    
    private var viewModel: MainTabBarViewModelProtocol
    
    init(viewModel: MainTabBarViewModelProtocol) {
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
    }
    
    private func setupUI() {
        tabBar.tintColor = .appYellow
        tabBar.backgroundColor = .appBlack
        tabBar.unselectedItemTintColor = .appGray
        
        view.addSubview(addButton)
    }
    
    private func setupConstraints() {
        addButton.snp.makeConstraints { make in
            make.size.equalTo(50.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(tabBar.snp.top).offset(25.0)
        }
    }
    @objc private func addDidTap() {
        viewModel.addDidTap()
    }
}
