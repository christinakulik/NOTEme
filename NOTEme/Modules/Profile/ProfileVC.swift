//
//  ProfileVC.swift
//  NOTEme
//
//  Created by Christina on 17.12.23.
//

import UIKit
import SnapKit

 protocol ProfileViewModelProtocol  {
     func makeTableView() -> UITableView
}

final class ProfileVC: UIViewController {
    
    private enum L10n {
        static let profile: String = "profile_tabbarItem".localized
    }

    private lazy var tableView: UITableView = viewModel.makeTableView()
    
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
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
        view.backgroundColor = .appGray
        
        view.addSubview(tableView)
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: L10n.profile,
                                       image: .TabBar.profile,
                                       tag: .zero)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

