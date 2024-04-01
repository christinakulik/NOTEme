//
//  HomeAdapterSpy.swift
//  NOTEmeTests
//
//  Created by Christina on 26.03.24.
//

import UIKit
import Storage
@testable import NOTEme

final class HomeAdapterSpy: HomeAdapterProtocol {
    
    var reloadDataCalled: Bool = false
    
    var reloadDataDToList: [any DTODescription] = []
    
    var buttonDTODidTap: ((UIButton, any DTODescription) -> Void)?
    
    var filterDidSelect: ((NOTEme.NotificationFilterType) -> Void)?
    
    func reloadData(_ dtoList: [any DTODescription]) {
        reloadDataCalled = true
        reloadDataDToList = dtoList
    }
    
    func makeTableView() -> UITableView {
        return .init()
    }
    
    
}
