//
//  HomeVM.swift
//  NOTEme
//
//  Created by Christina on 7.02.24.
//

import UIKit
import CoreData
import Storage

protocol HomeAdapterProtocol: AnyObject {
    func reloadData(_ dtoList: [any DTODescription])
    func makeTableView() -> UITableView
    var buttonDTODidTap: ((_ sender: UIButton,
                           _ dto: any DTODescription) -> Void)? { get set }
}

protocol HomeCoordinatorProtocol: AnyObject {
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate)
    func startEdit(dto: any DTODescription)
}

final class HomeVM: HomeViewModelProtocol {
    
    private let frcService: FRCService<BaseNotificationDTO>
    
    private let adapter: HomeAdapterProtocol
    
    private weak var coordinator: HomeCoordinatorProtocol?
    
    var tableView: UITableView?
    
    var showPopover: ((_ sender: UIButton) -> Void)?
    
    private var newDTO: (any DTODescription)?
    private let storage: AllNotificationStorage
    
    init(frcService: FRCService<BaseNotificationDTO>,
         adapter: HomeAdapterProtocol,
         coordinator: HomeCoordinatorProtocol,
         storage: AllNotificationStorage) {
        self.frcService = frcService
        self.adapter = adapter
        self.coordinator = coordinator
        self.storage = storage
        
        bind()
        
        frcService.startHandle()
        adapter.reloadData(frcService.fetchedDTOs)
    }
    
    func viewDidLoad() {
        frcService.startHandle()
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    // MARK: - Private Methods
    private func bind() {
        frcService.didChangeContent = { [weak adapter] dtoList in
            adapter?.reloadData(dtoList)
        }
        adapter.buttonDTODidTap = { [weak self] sender, dto in
            guard let self else { return }
            self.newDTO = dto
            self.coordinator?.showMenu(sender: sender, delegate: self)
        }
    }
}

extension HomeVM: MenuPopoverDelegate {
    func didSelect(action: MenuPopoverVC.Action) {
        guard let dto = newDTO else { return }
        switch action {
        case .edit:
            coordinator?.startEdit(dto: dto)
        case .delete:
            break;
        default: break
        }
    }
}
