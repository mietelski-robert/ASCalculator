//
//  Expression.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

struct Expression {

    // MARK: - Public properties -
    
    var value: String = ""
    
    let operators: Set<Operator>
    let parentheses: Set<Parenthesis>
    
    // MARK: - Initialization -
    
    init(value: String,
         operators: Set<Operator> = [],
         parentheses: Set<Parenthesis> = []) {
        
        self.value = value
        self.operators = operators
        self.parentheses = parentheses
    }
}

// MARK: - Parenthesis conversion -

extension Parenthesis {
    
    // MARK: - Initialization -
    
    init?(expression: Expression) {
        guard let character = expression.value.first, expression.value.count == 1,
            let parenthesis = expression.parentheses.first(where: { $0.symbol == character }) else {
                return nil
        }
        self.init(kind: parenthesis.kind, symbol: character, priority: parenthesis.priority)
    }
}

// MARK: - Operator conversion -

extension Operator {
    init?(expression: Expression) {
        
        // MARK: - Initialization -
        
        guard let character = expression.value.first, expression.value.count == 1,
            let `operator` = expression.operators.first(where: { $0.symbol == character }) else {
                return nil
        }
        self.init(symbol: character, priority: `operator`.priority, command: `operator`.command)
    }
}
