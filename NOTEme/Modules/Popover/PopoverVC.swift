//
//  PopoverVC.swift
//  NOTEme
//
//  Created by Christina on 8.02.24.
//

import UIKit
import SnapKit
import Storage
import CoreData

protocol PopoverViewModelProtocol  {
    func makeTableView() -> UITableView
}

final class PopoverVC: UIViewController {
 
    
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
    private var viewModel: PopoverViewModelProtocol
    
    init(viewModel: PopoverViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let popoverController = self.popoverPresentationController {
            popoverController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    
    private func setupUI() {
        view.addSubview(tableView)
       
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -36,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
        
    }
}

extension PopoverVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController)
    -> UIModalPresentationStyle {
        return .none
    }
}
