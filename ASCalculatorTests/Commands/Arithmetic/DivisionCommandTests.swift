//
//  DivisionCommandTests.swift
//  ASCalculatorTests
//
//  Created by Robert Mietelski on 08.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import XCTest
@testable import ASCalculator

class DivisionCommandTests: XCTestCase {
    
    // MARK: - Properties -
    
    let command = DivisionCommand()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExecute_ShouldNoThrowError() {
        XCTAssertNoThrow(try command.execute(lhs: 9.0, rhs: 2.5))
    }

    func testExecute_ShouldThrowError() {
        XCTAssertThrowsError(try command.execute(lhs: 9.0, rhs: 0.0))
    }
    
    func testExecute_ShouldReturnValidResult() {
        // Arrange
        let lhs: Double = 9.0
        let rhs: Double = 2.5
        
        // Act
        let result = try! command.execute(lhs: lhs, rhs: rhs)
        
        // Assert
        XCTAssertEqual(result, 3.6)
    }
}
