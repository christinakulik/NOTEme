//
//  HomeCoordinator.swift
//  NOTEme
//
//  Created by Christina on 12.12.23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return HomeAseembler.make()
    }
}
