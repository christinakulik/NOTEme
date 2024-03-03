//
//  HomeCoordinator.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit
import Storage

final class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        return HomeAseembler.make(coordinator: self)
    }
    
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate) {
        let menu = MenuPopoverBuilder.buildAddMenu(delegate: delegate,
                                                   sourceView: sender)
        rootVC?.present(menu, animated: true)
    }
    
    func startEdit(dto: any DTODescription) {
        
    }
    
}
