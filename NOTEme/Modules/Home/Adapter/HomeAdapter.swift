//
//  HomeAdapter.swift
//  NOTEme
//
//  Created by Christina on 23.02.24.
//

import UIKit
import Storage
import CoreData

final class HomeAdapter: NSObject {
    
    var filterDidSelect: ((NotificationFilterType) -> Void)?
    
    var buttonDTODidTap: ((_ sender: UIButton,
                           _ dto: any DTODescription) -> Void)?
    
    var dtoList: [any DTODescription] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableHeaderView: NotificationFilterView = {
        let frame = CGRect(x: .zero, y: .zero, width: .zero, height: 32.0)
        let headerView = NotificationFilterView(frame: frame)
        headerView.delegate = self
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableHeaderView = tableHeaderView
        return tableView
    }()
    
    override init() {
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DateNotificationCell.self)
        tableView.register(TimerNotificationCell.self)
        tableView.register(LocationNotificationCell.self)
    }
}
// MARK: - TableViewDataSource
extension HomeAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dtoList.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) 
    -> UITableViewCell {
        let dto = dtoList[indexPath.section]
        
        if let dateDTO = dto as? DateNotificationDTO {
            let cell = tableView.dequeue(at: indexPath) as DateNotificationCell
            cell.setup(dateDTO)
            cell.backgroundColor = .clear
            cell.buttonDidTap = { [weak self] sender in
                self?.buttonDTODidTap?(sender, dto)
            }
            return cell
        } else if let timerDTO = dto as? TimerNotificationDTO {
            let cell = tableView.dequeue(at: indexPath) as TimerNotificationCell
            cell.setup(timerDTO)
            cell.backgroundColor = .clear
            cell.buttonDidTap = { [weak self] sender in
                self?.buttonDTODidTap?(sender, dto)
            }
            return cell
        } else if let locationDTO = dto as? LocationNotificationDTO {
            let cell = tableView.dequeue(at: indexPath) as LocationNotificationCell
            cell.setup(locationDTO)
            cell.backgroundColor = .clear
            cell.buttonDidTap = { [weak self] sender in
                self?.buttonDTODidTap?(sender, dto)
            }
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - TableViewDelegate
extension HomeAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, 
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, 
                   willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dto = dtoList[indexPath.section]
        
        if dto is DateNotificationDTO {
            return 87.0
        } else if dto is TimerNotificationDTO {
            return 130.0
        } else if dto is LocationNotificationDTO {
            return 247.0
        }
        return 0
    }
}

extension HomeAdapter: HomeAdapterProtocol {
    
    func reloadData(_ dtoList: [any DTODescription]) {
        self.dtoList = dtoList
        tableView.reloadData()
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
    
}
    
extension HomeAdapter: NotificationFilterViewDelegate {
    func notificationFilterView(_ filterView: NotificationFilterView,
                                didSelect type: NotificationFilterType) {
        filterDidSelect?(type)
    }
}
    
    

