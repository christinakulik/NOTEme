//
//  PopoverAssembler.swift
//  NOTEme
//
//  Created by Christina on 8.02.24.
//

import UIKit

final class PopoverAssembler {
    
    private init() {}
    
    static func make(coordinator: PopoverCoordinatorProtocol) -> UIViewController {
        let vm = PopoverVM(coordinator: coordinator,
                           adapter: PopoverAdapter())
        let vc = PopoverVC(viewModel: vm)
        return vc
    }
}
