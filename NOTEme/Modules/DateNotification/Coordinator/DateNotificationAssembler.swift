//
//  CreateDateAssembler.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage

final class DateNotificationAssembler {
    private init() {}
    
    static func make(container: Container,
                     coordinator: DateNotificationCoordinatorProtocol,
                     dtoToEdit: DateNotificationDTO? = nil) -> UIViewController {
        
        let vm = DateNotificationVM(coordinator: coordinator,
                                    storage: DateNotificationStorage(),
                                    dtoToEdit: dtoToEdit)
        
        return DateNotificationVC(viewModel: vm)
    }
}
