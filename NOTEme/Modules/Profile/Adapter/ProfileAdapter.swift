//
//  ProfileAdapter.swift
//  NOTEme
//
//  Created by Christina on 25.01.24.
//

import UIKit

final class ProfileAdapter: NSObject {
    
    var sections: [ProfileSections] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var didSelectRow: ((ProfileSettingsRows) -> Void)?
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorColor = .appGrayContent
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 16,
                                                bottom: 0,
                                                right: 16)
        return tableView
    }()
    
    override init() {
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ProfileAccountTableViewCell.self,
                           forCellReuseIdentifier:
                            "\(ProfileAccountTableViewCell.self)")
        tableView.register(ProfileSettingTableViewCell.self,
                           forCellReuseIdentifier:
                            "\(ProfileSettingTableViewCell.self)")
    }
    
}

extension ProfileAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int {
        let section = sections[section]
        return section.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .account(let email):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ProfileAccountTableViewCell",
                for: indexPath) as! ProfileAccountTableViewCell
            cell.setup(email)
            return cell
        case .settings(let rows):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ProfileSettingTableViewCell",
                for: indexPath) as! ProfileSettingTableViewCell
            cell.setup(rows[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard
            case .settings(let rows) = sections[indexPath.section]
        else { return }
        
        let selectedRow = rows[indexPath.row]
        didSelectRow?(selectedRow)
    }
}

extension ProfileAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int)
    -> UIView? {
        let section = sections[section]
        let headerView = ProfileHeaderView()
        headerView.set(with: section.headerText)
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .account:
            return 73.0
        case .settings:
            return 43.0
        }
    }
}

extension ProfileAdapter: ProfileAdapterProtocol {
    
    func reloadData(with sections: [ProfileSections]) {
        self.sections = sections
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
}
