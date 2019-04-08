//
//  TruncateCommandTests.swift
//  ASCalculatorTests
//
//  Created by Robert Mietelski on 08.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import XCTest
@testable import ASCalculator

class TruncateCommandTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit_ShouldSetNumberOfCharacter() {
        // Arrange
        let numberOfCharacter: Int = 18
        
        // Act
        let command = TruncateCommand(numberOfCharacter: numberOfCharacter)
        
        // Assert
        XCTAssertEqual(command.numberOfCharacter, numberOfCharacter)
    }
    
    func testExecute_ShouldReturnExpressionTruncatedUpToTwoCharacters() {
        // Arrange
        let numberOfCharacter: Int = 2
        let command = TruncateCommand(numberOfCharacter: numberOfCharacter)
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "4.9+372") { result in
            // Assert
            XCTAssertEqual(result, TransformationResult.expression(value: "4.9+3"))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldReturnEmptyExpression() {
        // Arrange
        let numberOfCharacter: Int = TruncateCommand.expressionLength
        let command = TruncateCommand(numberOfCharacter: numberOfCharacter)
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "4.9+372") { result in
            // Assert
            XCTAssertEqual(result, TransformationResult.expression(value: ""))

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
