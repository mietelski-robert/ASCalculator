//
//  DivisionCommand.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class DivisionCommand {
    
}

// MARK: - Command error -

extension DivisionCommand {
    enum CommandError: LocalizedError {
        case dividedByZero
        
        var errorDescription: String? {
            switch self {
            case .dividedByZero:
                return "error.dividedByZero".localized
            }
        }
    }
}

// MARK: - ArithmeticCommandInterface implementation -

extension DivisionCommand: ArithmeticCommandInterface {
    func execute(lhs: Double, rhs: Double) throws -> Double {
        guard rhs != 0 else {
            throw CommandError.dividedByZero
        }
        return lhs / rhs
    }
}
