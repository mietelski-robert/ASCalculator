//
//  PostfixConverter.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class PostfixConverter {

    // MARK: - Access methods -
    
    func convert(infixInput: [Argument]) -> [Argument] {
        var result = [Argument]()
        var stack = [Argument]()
        
        for argument in infixInput {
            switch argument {
            case .number:
                result.append(argument)
            case .operator(let currentValue):
                while let last = stack.last,
                    case .operator(let previousValue) = last,
                    previousValue.priority >= currentValue.priority {
                        
                        result.append(last)
                        stack.removeLast()
                }
                stack.append(argument)
            case .parenthesis(let value):
                switch value.kind {
                case .open:
                    stack.append(argument)
                case .close:
                    while let last = stack.last, case .operator = last {
                        result.append(last)
                        stack.removeLast()
                    }
                    stack.removeLast()
                }
            }
        }
        return result + stack.reversed()
    }
}
