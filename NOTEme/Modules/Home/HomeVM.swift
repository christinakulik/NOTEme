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
    var buttonDTODidTap: ((_ sender: UIButton,
                           _ dto: any DTODescription) -> Void)? { get set }
    var filterDidSelect: ((NotificationFilterType) -> Void)? { get set }
    func reloadData(_ dtoList: [any DTODescription])
    func makeTableView() -> UITableView
}

protocol HomeCoordinatorProtocol: AnyObject {
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate)
    func startEdit(dto: any DTODescription)
}

protocol HomeStorageUseCase {
    func delete(dto: any DTODescription)
}

protocol HomeFRCSrviceUseCase {
    var fetchedDTOs: [any DTODescription] { get }
    var didChangeContent: (([any DTODescription]) -> Void)? { get set }
    func startHandle()
}

final class HomeVM: HomeViewModelProtocol {
    
    var tableView: UITableView?
    
    var showPopover: ((_ sender: UIButton) -> Void)?
   
    private var frcService: HomeFRCSrviceUseCase
    private let adapter: HomeAdapterProtocol
    private weak var coordinator: HomeCoordinatorProtocol?
    private let storage: HomeStorageUseCase
    private var newDTO: (any DTODescription)?
    
    private var selectedFilter: NotificationFilterType = .all {
        didSet {
            adapter.reloadData(filterResults())
        }
    }
    
    init(frcService: HomeFRCSrviceUseCase,
         adapter: HomeAdapterProtocol,
         coordinator: HomeCoordinatorProtocol,
         storage: HomeStorageUseCase ) {
        self.frcService = frcService
        self.adapter = adapter
        self.coordinator = coordinator
        self.storage = storage
        
        bind()
        
//        frcService.startHandle()
    }
    
    func viewDidLoad() {
        frcService.startHandle()
        adapter.reloadData(frcService.fetchedDTOs)
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    // MARK: - Private Methods
    private func filterResults() -> [any DTODescription] {
        return frcService.fetchedDTOs.filter { dto in
            switch selectedFilter {
            case .date:
                return dto is DateNotificationDTO
            case .timer:
                return dto is TimerNotificationDTO
            case .location:
                return dto is LocationNotificationDTO
            default:
                return true
            }
        }
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak self] _ in
            self?.adapter.reloadData(self?.filterResults() ?? [])
        }
        adapter.buttonDTODidTap = { [weak self] sender, dto in
            guard let self else { return }
            self.newDTO = dto
            self.coordinator?.showMenu(sender: sender, delegate: self)
        }
        adapter.filterDidSelect = { [weak self] type in
            self?.selectedFilter = type
        }
    }
}

extension HomeVM: MenuPopoverDelegate {
    func didSelect(action: MenuPopoverVC.Action) {
        guard let dto = newDTO else { return }
        switch action {
        case .edit:
            switch dto {
            case is DateNotificationDTO:
                coordinator?.startEdit(dto: dto as! DateNotificationDTO)
            case is TimerNotificationDTO:
                coordinator?.startEdit(dto: dto as! TimerNotificationDTO)
            default: break
            }
        case .delete:
            storage.delete(dto: dto)
        default: break
        }
    }
}
