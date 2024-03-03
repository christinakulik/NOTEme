//
//  MenuPopoverVC.swift
//  NOTEme
//
//  Created by Christina on 27.02.24.
//

import UIKit

protocol MenuPopoverAdapterProtocol {
    
    var tableView: UITableView { get }
    var didSelectAction: ((MenuPopoverVC.Action) -> Void)? { get set }
    var contentHeight: CGFloat { get }
}

protocol MenuPopoverDelegate: AnyObject {
    func didSelect(action: MenuPopoverVC.Action)
}

final class MenuPopoverVC: UIViewController {
    private enum L10n {
        static let calendarTitle: String = "popover_calendar".localized
        static let locationTitle: String = "popover_location".localized
        static let timerTitle: String = "popover_timer".localized
        static let editTitle: String = "popover_edit".localized
        static let deleteTitle: String = "popover_delete".localized
    }
    
    private enum Const {
        static let contentWidht: CGFloat = 180.0
    }
    
    enum Action: MenuActionItem {
        case edit
        case delete
        case calendar
        case timer
        case location
        
        var title: String {
            switch self {
            case .edit:
                return L10n.editTitle
            case .delete:
                return L10n.deleteTitle
            case .calendar:
                return L10n.calendarTitle
            case .timer:
                return L10n.timerTitle
            case .location:
                return L10n.locationTitle
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .calendar: return .Popover.calendar
            case .location: return .Popover.location
            case .timer: return .Popover.timer
            case .edit: return .Popover.edit
            case .delete: return .Popover.delete
            }
        }
    }
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .popover } set {}
    }
    
    private var adapter: MenuPopoverAdapterProtocol
    private lazy var tableView: UITableView = adapter.tableView

    private weak var delegate: MenuPopoverDelegate?
    
    init(delegate: MenuPopoverDelegate,
         adapter: MenuPopoverAdapterProtocol,
         sourceView: UIView) {
        self.delegate = delegate
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)
        
        setupPopover(sourceView: sourceView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupUI()
        setupConstrans()
    }
    
    private func bind() {
        adapter.didSelectAction = { [weak self] action in
            self?.dismiss(animated: true, completion: {
                self?.delegate?.didSelect(action: action)
            })
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
    }
    
    private func setupConstrans() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(
                self.view.safeAreaLayoutGuide.snp.verticalEdges)
            make.height.equalTo(adapter.contentHeight)
        }
    }
    
    private func setupPopover(sourceView: UIView) {
        preferredContentSize = CGSize(width: Const.contentWidht,
                                      height: adapter.contentHeight)
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.delegate = self
        popoverPresentationController?.sourceRect = CGRect(x: sourceView.bounds.midX,
                                                           y: sourceView.bounds.midY,
                                                           width: .zero,
                                                           height: .zero)
    }
}

extension MenuPopoverVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) 
    -> UIModalPresentationStyle {
        return .none
    }
}
