//
//  HomeAseembler.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit
import CoreData
import Storage

final class HomeAseembler {
    
    private init() {}
    
    static func make(coordinator: HomeCoordinatorProtocol) -> UIViewController {
        let vm = HomeVM(frcService: makeFRC(),
                        adapter: HomeAdapter(),
                        coordinator: coordinator,
                        storage: AllNotificationStorage())
        return HomeVC(viewModel: vm)
    }
    
    private static func makeFRC() ->
    FRCService<BaseNotificationDTO> {
        return .init { request in
            request.predicate = .Notification.allNotCompleted
            request.sortDescriptors = [.Notification.byDate]
        }
    }
}
