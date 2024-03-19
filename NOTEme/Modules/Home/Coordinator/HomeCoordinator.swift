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
        let vc =  HomeAseembler.make(coordinator: self)
        rootVC = vc
        return vc
    }
    
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate) {
        let menu = MenuPopoverBuilder.buildEditMenu(delegate: delegate,
                                                    sourceView: sender)
        rootVC?.present(menu, animated: true)
    }
    
    func startEdit(dto: any DTODescription) {
        if let dateDTO = dto as? DateNotificationDTO {
                let coordinator = 
            DateNotificationCoordinator(container: Container(),
                                        dtoToEdit: dateDTO)
                children.append(coordinator)
                let vc = coordinator.start()
                
                coordinator.onDidFinish = { [weak self] coordinator in
                    self?.children.removeAll { coordinator == $0 }
                    vc.dismiss(animated: true)
                }
                rootVC?.present(vc, animated: true)
            }
    }
    
}
