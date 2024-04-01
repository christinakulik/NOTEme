//
//  HomeViewModelTests.swift
//  NOTEmeTests
//
//  Created by Christina on 26.03.24.
//

import XCTest
@testable import NOTEme

final class HomeViewModelTests: XCTestCase {
    
    private let adapterSpy = HomeAdapterSpy()
    private let storagerSpy = HomeStorageSpy()
    private let frcSpy = HomeFRCServiceSpy()
    private let coordinatorSpy = HomeCoordinatorSpy()
    
    private func makeSut() -> HomeVM {
        return HomeVM(frcService: frcSpy,
                      adapter: adapterSpy,
                      coordinator: coordinatorSpy,
                      storage: storagerSpy)
    }
    
    private func clearData() {
        frcSpy.startHandleCalled = false
        adapterSpy.reloadDataCalled = false
        adapterSpy.reloadDataDToList = []
    }
    
    func test_viewDidLoad() {
        clearData()
        let sut = makeSut()
        
        frcSpy.fetchedDTOs = [HomeDTOMock(), HomeDTOMock()]
        
        sut.viewDidLoad()
        
        XCTAssert(frcSpy.startHandleCalled)
        XCTAssert(adapterSpy.reloadDataCalled)
        XCTAssertEqual(frcSpy.fetchedDTOs.count, 
                       adapterSpy.reloadDataDToList.count)
    }
    
    func test_filter() {
        
    }
}

