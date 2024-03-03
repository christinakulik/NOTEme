//
//  HomeVC.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit
import Storage
import CoreData
import SnapKit

protocol HomeViewModelProtocol: AnyObject  {
    func viewDidLoad()
    func makeTableView() -> UITableView
}

final class HomeVC: UIViewController {
    
    private enum L10n {
        static let home: String = "home_tabbarItem".localized
    }
    
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        setupUI()
        setupConstraints()

}
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .appGray
        view.addSubview(tableView)
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: L10n.home,
                                       image: .TabBar.home,
                                       tag: .zero)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
