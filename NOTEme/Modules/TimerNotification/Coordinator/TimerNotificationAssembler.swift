//
//  TimerNotificationAssembler.swift
//  NOTEme
//
//  Created by Christina on 9.02.24.
//

import UIKit
import Storage

final class TimerNotificationAssembler {
    private init() {}
    
    static func make(container: Container,
                     coordinator: TimerNotificationCoordinatorProtocol) 
    -> UIViewController {
        
        let vm = TimerNotificationVM(coordinator: coordinator,
                                     storage: TimerNotificationStorage(),
                                     notificationService: NotificationService())
        
        return TimerNotificationVC(viewModel: vm)
    }
}

