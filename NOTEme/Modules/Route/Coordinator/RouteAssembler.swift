//
//  RouteAssembler.swift
//  NOTEme
//
//  Created by Christina on 10.03.24.
//

import UIKit
import Storage
import MapKit

final class RouteAssembler {
    private init() {}
    
    static func make(_ coordinator: RouteCoordinatorProtocol,
                     container: Container,
                     delegate: RouteModuleDelegate?,
                     region: MKCoordinateRegion?
    ) -> UIViewController {
        let vm = RouteVM(coordinator: coordinator,
                         adapter: RouteAdapter(),
                         delegate: delegate,
                         region: region)
        let vc = RouteVC(viewModel: vm)
        return vc
    }
}
