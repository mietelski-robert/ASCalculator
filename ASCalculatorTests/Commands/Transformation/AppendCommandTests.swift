//
//  AppendCommandTests.swift
//  ASCalculatorTests
//
//  Created by Robert Mietelski on 08.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import XCTest
@testable import ASCalculator

class AppendCommandTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit_ShouldSetValue() {
        // Arrange
        let value: String = "5"
        
        // Act
        let command = AppendCommand(value: value)
        
        // Assert
        XCTAssertEqual(command.value, value)
    }

    func testExecute_ShouldReturnExpressionWithAppendedValue() {
        // Arrange
        let value: String = "5"
        let pattern: String = "4.9+"
        let command = AppendCommand(value: value)
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: pattern) { result in
            // Assert
            XCTAssertEqual(result, TransformationResult.expression(value: "4.9+5"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldReturnExpressionWithNotAppendedValue() {
        // Arrange
        let value: String = ""
        let pattern: String = "4.9+"
        let command = AppendCommand(value: value)
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: pattern) { result in
            // Assert
            XCTAssertEqual(result, TransformationResult.expression(value: "4.9+"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
