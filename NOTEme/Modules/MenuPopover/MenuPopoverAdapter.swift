//
//  MenuPopoverAdapter.swift
//  NOTEme
//
//  Created by Christina on 27.02.24.
//

import UIKit

final class MenuPopoverAdapter: NSObject, MenuPopoverAdapterProtocol {
    
    private enum Const {
        static let rowHeight: CGFloat = 40.0
    }
    
    private(set)  var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 40.0
        return tableView
    }()
    
    
    var contentHeight: CGFloat {
        return CGFloat(actions.count) * Const.rowHeight
    }
    
    private var actions: [MenuPopoverVC.Action]
    var didSelectAction: ((MenuPopoverVC.Action) -> Void)?
    
    
    init(actions: [MenuPopoverVC.Action]) {
        self.actions = actions
        super.init()
       
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuActionCell.self)
    }
    
}
extension MenuPopoverAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) 
    -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let cell: MenuActionCell = tableView.dequeue(at: indexPath)
        cell.setup(actions[indexPath.row])
        return cell
    }
}

extension MenuPopoverAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let action = actions[indexPath.row]
        didSelectAction?(action)
    }
}
