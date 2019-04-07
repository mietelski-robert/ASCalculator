//
//  Argument.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

enum Argument {
    case number(value: Double)
    case `operator`(value: Operator)
    case parenthesis(value: Parenthesis)
    
    var priority: Int {
        switch self {
        case .number:
            return -1
        case .operator(let value):
            return value.priority + 1
        case .parenthesis(let value):
            return value.priority
        }
    }
}
