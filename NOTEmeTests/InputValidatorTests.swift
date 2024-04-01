//
//  InputValidatorTests.swift
//  NOTEmeTests
//
//  Created by Christina on 26.03.24.
//

import XCTest
@testable import NOTEme

final class InputValidatorTests: XCTestCase {
    
    func test_validEmail() {
        let sut = InputValidator()
        let validEmail = "abcd@gmail.com"
        
        let result = sut.validate(email: validEmail)
        
        XCTAssert(result)
    }
    
    func test_invalidEmail() {
        let sut = InputValidator()
        let invalidEmail = "@@gmail.com"
        
        let result = sut.validate(email: invalidEmail)
        
        XCTAssertFalse(result)
    }
    
    func test_validDoubleExtensionEmail() {
        let sut = InputValidator()
        let validEmail = "abcd@gmail.com.by"
        
        let result = sut.validate(email: validEmail)
      
        XCTAssert(result)
    }
    
    func test_nilEmail() {
        let sut = InputValidator()
        
        let result = sut.validate(email: nil)
        
        XCTAssertFalse(result)
    }
}
