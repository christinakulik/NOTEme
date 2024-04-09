//
//  AnnotationsMapAssembler.swift
//  NOTEme
//
//  Created by Christina on 8.04.24.
//

import UIKit

final class AnnotationsMapAssembler {
    private init() {}
    
    static func make(_ coordinator: AnnotationsMapCoordinatorProtocol) -> UIViewController {
        let vm = AnnotationsMapVM(coordinator: coordinator)
        let vc = AnnotationsMapVC(viewmodel: vm)
        return vc
    }
}
