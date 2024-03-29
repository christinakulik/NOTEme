//
//  PopoverAdapter.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit

final class PopoverAdapter: NSObject {
    
    var rows: [PopoverRows] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var didSelectRow: ((PopoverRows) -> Void)?
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorColor = .appGrayContent
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 0,
                                                bottom: 0,
                                                right: 0)
        return tableView
    }()
    
    override init() {
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(PopoverTableViewCell.self)
    }
}

extension PopoverAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeue(at: indexPath) as PopoverTableViewCell
        cell.setup(row)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRow = rows[indexPath.row]
        didSelectRow?(selectedRow)
    }
    
}


extension PopoverAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 41
    }
}

extension PopoverAdapter: PopoverAdapterProtocol {
    
    func reloadData(with rows: [PopoverRows]) {
        self.rows = rows
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
}
