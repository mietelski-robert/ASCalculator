//
//  NumberConverter.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class NumberConverter: NSObject {
    
    // MARK: - Access methods -
    
    func calculate(postfixInput: [Argument]) throws -> Double {
        var stack = [Double]()
        
        for argument in postfixInput {
            switch argument {
            case .number(let value):
                stack.append(value)
            case .operator(let value):
                guard let rhs = stack.last, let lhs = stack.dropLast().last else {
                    throw ConverterError.invalidExpression
                }
                let result = try value.command.execute(lhs: lhs, rhs: rhs)
                stack = Array(stack.dropLast(2)) + [result]
            case .parenthesis:
                throw ConverterError.invalidExpression
            }
        }
        guard let value = stack.popLast(), stack.isEmpty else  {
            throw ConverterError.invalidExpression
        }
        return value
    }
}

// MARK: - Converter error -

extension NumberConverter {
    enum ConverterError: LocalizedError {
        case invalidExpression
        
        var errorDescription: String? {
            switch self {
            case .invalidExpression:
                return "error.invalidExpression".localized
            }
        }
    }
}
