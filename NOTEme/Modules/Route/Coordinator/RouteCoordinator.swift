//
//  RouteCoordinator.swift
//  NOTEme
//
//  Created by Christina on 10.03.24.
//

import UIKit
import Storage
import MapKit

final class RouteCoordinator: Coordinator {
    
    private let container: Container
    private weak var delegate: RouteModuleDelegate?
    private let region: MKCoordinateRegion?
    
    init(container: Container,
         delegate: RouteModuleDelegate?,
         region: MKCoordinateRegion?
    ) {
        self.container = container
        self.delegate = delegate
        self.region = region
    }
    
    override func start() -> UIViewController {
        return RouteAssembler.make(self,
                                   container: container,
                                   delegate: delegate,
                                   region: region)
    }
}

extension RouteCoordinator:
    RouteCoordinatorProtocol {}
