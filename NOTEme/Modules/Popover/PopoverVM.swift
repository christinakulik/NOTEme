//
//  PopoverVM.swift
//  NOTEme
//
//  Created by Christina on 8.02.24.
//

import UIKit

protocol PopoverCoordinatorProtocol: AnyObject  {
    func openCreateDate()
    func openCreateTimer()
}

protocol PopoverAdapterProtocol {
    var didSelectRow: ((PopoverRows) -> Void)? { get set}
    
    func reloadData(with rows: [PopoverRows])
    func makeTableView() -> UITableView
}

final class PopoverVM: PopoverViewModelProtocol {

    private weak var coordinator: PopoverCoordinatorProtocol?
    private var adapter: PopoverAdapterProtocol
    
    private var rows: [PopoverRows] {
        return PopoverRows.allCases
    }
    
    init(coordinator: PopoverCoordinatorProtocol,
         adapter: PopoverAdapterProtocol) {
        self.coordinator = coordinator
        self.adapter = adapter
        
        commonInit()
        bind()
    }
    
    func bind() {
        adapter.didSelectRow = { [weak self] row in
            switch row {
            case .calendar:
                self?.dateDidTap()
            case .location:
                self?.locationDidTap()
            case .timer:
                self?.timerDidTap()
            }
        }
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    private func commonInit() {
        adapter.reloadData(with: rows)
    }
    
    func dateDidTap() {
        coordinator?.openCreateDate()
    }
    
    func locationDidTap() {
        coordinator?.openCreateDate()
    }
    
    func timerDidTap() {
        coordinator?.openCreateTimer()
    }
}
