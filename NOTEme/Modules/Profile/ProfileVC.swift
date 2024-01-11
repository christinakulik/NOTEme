//
//  ProfileVC.swift
//  NOTEme
//
//  Created by Christina on 17.12.23.
//

import UIKit
import SnapKit

private enum L10n {
    static let profile: String = "profile_tabbarItem".localized
}

 protocol ProfileViewModelProtocol  {

    func getCurrentEmail() -> ProfileAccountModel
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func titleForHeaderInSection(_ section: Int) -> String?
    func logoutDidTap()
}

final class ProfileVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileAccountTableViewCell.self,
                           forCellReuseIdentifier:
                            "\(ProfileAccountTableViewCell.self)")
        tableView.register(ProfileSettingTableViewCell.self,
                           forCellReuseIdentifier:
                            "\(ProfileSettingTableViewCell.self)")
        return tableView
    }()
    
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
        
        tableView.backgroundColor = .appGray
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: L10n.profile,
                                       image: .TabBar.profile,
                                       tag: .zero)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

extension ProfileVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ProfileAccountTableViewCell",
                for: indexPath) as! ProfileAccountTableViewCell
            cell.setup(with: viewModel.getCurrentEmail())
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ProfileSettingTableViewCell",
                for: indexPath) as! ProfileSettingTableViewCell
            cell.onLogoutTap = { [weak self] in
                self?.viewModel.logoutDidTap()
            }
            return cell
        }
    }
}

extension ProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
           return viewModel.heightForRowAt(indexPath: indexPath)
       }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) 
    -> UIView? {
        let headerView = ProfileHeaderView()
        headerView.set(with: viewModel.titleForHeaderInSection(section) ?? "")
        return headerView
    }
}

