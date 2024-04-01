//
//  HomeFRCServiceSpy.swift
//  NOTEmeTests
//
//  Created by Christina on 26.03.24.
//

import Foundation
import Storage
@testable import NOTEme

final class HomeFRCServiceSpy: HomeFRCSrviceUseCase {
    
    var reloadDataCalled: Bool = false
    
    var startHandleCalled: Bool = false
    
    var fetchedDTOs: [ any DTODescription] = []
    
    var didChangeContent: (([any DTODescription]) -> Void)?
    
    func startHandle() {
        startHandleCalled = true
    }
  
}
