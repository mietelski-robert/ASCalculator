//
//  SubtractionCommand.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class SubtractionCommand {
    
}

// MARK: - ArithmeticCommandInterface implementation -

extension SubtractionCommand: ArithmeticCommandInterface {
    func execute(lhs: Double, rhs: Double) throws -> Double {
        return lhs - rhs
    }
}
