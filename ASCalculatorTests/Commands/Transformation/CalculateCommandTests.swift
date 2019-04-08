//
//  CalculateCommandTests.swift
//  ASCalculatorTests
//
//  Created by Robert Mietelski on 08.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import XCTest
@testable import ASCalculator

class CalculateCommandTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit_ShouldSetService() {
        // Arrange
        let service = CalculateService()
        
        // Act
        let command = CalculateCommand(service: service)
        
        // Assert
        XCTAssertTrue(command.service === service)
    }
    
    func testExecute_ShouldCompleteWithError() {
        // Arrange
        let command = CalculateCommand()
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "4.0÷0", completion: { result in
            // Assert
            if case .error(let error) = result {
                XCTAssertNotNil(error)
            } else {
                XCTFail("Test failed")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldCompleteWithSuccess() {
        // Arrange
        let command = CalculateCommand()
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "4.0÷2", completion: { result in
            // Assert
            if case .number(let value) = result {
                XCTAssertNotNil(value)
            } else {
                XCTFail("Test failed")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldCompleteWithResultEqual30() {
        // Arrange
        let command = CalculateCommand()
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "17.3+12.7", completion: { result in
            // Assert
            if case .number(let value) = result {
                XCTAssertEqual(value, 30.0)
            } else {
                XCTFail("Test failed")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldCompleteWithResultEqual5() {
        // Arrange
        let command = CalculateCommand()
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "17.5-12.5", completion: { result in
            // Assert
            if case .number(let value) = result {
                XCTAssertEqual(value, 5.0)
            } else {
                XCTFail("Test failed")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldCompleteWithResultEqual210() {
        // Arrange
        let command = CalculateCommand()
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "17.5*12.0", completion: { result in
            // Assert
            if case .number(let value) = result {
                XCTAssertEqual(value, 210.0)
            } else {
                XCTFail("Test failed")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldCompleteWithResultEqual376() {
        // Arrange
        let command = CalculateCommand()
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "5640÷15", completion: { result in
            // Assert
            if case .number(let value) = result {
                XCTAssertEqual(value, 376.0)
            } else {
                XCTFail("Test failed")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecute_ShouldCompleteWithResultEqualMiuns15() {
        // Arrange
        let command = CalculateCommand()
        let expectation = XCTestExpectation(description: "execute")
        
        // Act
        command.execute(with: "5-(15+5)", completion: { result in
            // Assert
            if case .number(let value) = result {
                XCTAssertEqual(value, -15.0)
            } else {
                XCTFail("Test failed")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
}
