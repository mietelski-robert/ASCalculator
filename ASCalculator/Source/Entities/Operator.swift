//
//  Operator.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

struct Operator: Hashable {
    
    // MARK: - Public properties -
    
    let symbol: Character
    let priority: Int
    let command: ArithmeticCommandInterface
    
    var hashValue: Int {
        return self.symbol.hashValue ^ self.priority.hashValue
    }
    
    // MARK: - Initialization -
    
    init(symbol: Character, priority: Int, command: ArithmeticCommandInterface) {
        self.symbol = symbol
        self.priority = priority
        self.command = command
    }
}

extension Operator: Equatable {
    static func == (lhs: Operator, rhs: Operator) -> Bool {
        return lhs.symbol == rhs.symbol && lhs.priority == rhs.priority
    }
}
