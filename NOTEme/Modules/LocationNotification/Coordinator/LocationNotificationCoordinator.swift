//
//  LocationNotificationCoordinator.swift
//  NOTEme
//
//  Created by Christina on 5.03.24.
//

import UIKit
import Storage
import MapKit

final class LocationNotificationCoordinator: Coordinator {
    
    private let container: Container
    
    private var rootVC: UIViewController?
    private let dto: LocationNotificationDTO?
    
    init(container: Container,
         dto: LocationNotificationDTO?) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        let vc =  LocationNotificationAssembler.make(container: container,
                                                     coordinator: self,
                                                     dtoToEdit: dto)
        rootVC = vc
        return vc
    }
}

extension LocationNotificationCoordinator:
    LocationNotificationCoordinatorProtocol {
    
    func openRoute(delegate: RouteModuleDelegate?, 
                   region: MKCoordinateRegion?) {
        let coordinator = RouteCoordinator(
            container: container,
            delegate: delegate,
            region: region)
        
        children.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
}
