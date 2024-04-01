//
//  LocationNotificationAssembler.swift
//  NOTEme
//
//  Created by Christina on 5.03.24.
//

import UIKit
import Storage

final class LocationNotificationAssembler {
    private init() {}
    
    static func make(container: Container,
                     coordinator: LocationNotificationCoordinatorProtocol,
                     dtoToEdit: LocationNotificationDTO? = nil) 
    -> UIViewController {
        
        let vm = LocationNotificationVM(coordinator: coordinator,
                                        storage: LocationNotificationStorage(),
                                        dtoToEdit: dtoToEdit, notificationService: NotificationService())
        
        return LocationNotificationVC(viewModel: vm)
    }
}
