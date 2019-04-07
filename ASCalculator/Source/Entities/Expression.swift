//
//  Expression.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class Expression {

    // MARK: - Public properties -
    
    var value: String = ""
    
    let operators: Set<Operator>
    let parentheses: Set<Parenthesis>
    let validators: [ValidatorInterface]
    
    // MARK: - Computable properties -
    
    var length: Int {
        return self.value.count
    }

    // MARK: - Private properties -
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = String(NumberSymbol.dot)
        formatter.plusSign = String(OperatorSymbol.addition)
        formatter.minusSign = String(OperatorSymbol.subtraction)
        
        return formatter
    }()
    
    // MARK: - Initialization -
    
    init(value: String,
         operators: Set<Operator> = [],
         parentheses: Set<Parenthesis> = [],
         validators: [ValidatorInterface] = []) {
        
        self.value = value
        self.operators = operators
        self.parentheses = parentheses
        self.validators = validators
    }
    
    // MARK: - Access methods -
    
    func split() throws -> [Argument] {
        var parenthesisStack = [Parenthesis]()
        var operatorStack = [Operator]()
        var numberStack = [Character]()
        var arguments = [Argument]()
        
        for character in self.value {
            let expression = Expression(value: String(character),
                                        operators: self.operators,
                                        parentheses: self.parentheses)
            
            if let currentParenthesis = Parenthesis(expression: expression) {
                switch currentParenthesis.kind {
                case .open:
                    if let lastOperator = operatorStack.last {
                        arguments.append(Argument.operator(value: lastOperator))
                        operatorStack.removeLast()
                    } else if !numberStack.isEmpty {
                        throw ValidationError.invalidExpression
                    }
                    arguments.append(Argument.parenthesis(value: currentParenthesis))
                    parenthesisStack.append(currentParenthesis)
                case .close:
                    if let lastParenthesis = parenthesisStack.last,
                        lastParenthesis.priority == currentParenthesis.priority,
                        operatorStack.isEmpty, !numberStack.isEmpty {
                        
                        if let number = Double(characters: numberStack) {
                            arguments.append(Argument.number(value: number))
                            numberStack.removeAll()
                        } else {
                            throw ValidationError.invalidExpression
                        }
                        arguments.append(Argument.parenthesis(value: currentParenthesis))
                        parenthesisStack.removeLast()
                    } else {
                        throw ValidationError.invalidExpression
                    }
                }
            } else if let currentOperator = Operator(expression: expression) {
                if let lastOperator = operatorStack.last {
                    if (currentOperator.priority != 0 && currentOperator.priority == lastOperator.priority) || // **, //
                        currentOperator.priority > lastOperator.priority || // +*, -/
                        operatorStack.count > 1 {
                        throw ValidationError.invalidExpression
                    } else {
                        numberStack.append(character)
                    }
                } else {
                    if !numberStack.isEmpty {
                        if let number = Double(characters: numberStack) {
                            arguments.append(Argument.number(value: number))
                            numberStack.removeAll()
                            operatorStack.append(currentOperator)
                        } else {
                            throw ValidationError.invalidExpression
                        }
                    } else if arguments.isEmpty && currentOperator.priority == 0 {
                        if currentOperator.symbol == OperatorSymbol.subtraction {
                            numberStack.append(character)
                        }
                    } else if !arguments.isEmpty {
                        operatorStack.append(currentOperator)
                    } else {
                        throw ValidationError.invalidExpression
                    }
                }
            } else if Double(characters: [character]) != nil {
                if let lastOperator = operatorStack.last {
                    arguments.append(Argument.operator(value: lastOperator))
                    operatorStack.removeLast()
                }
                numberStack.append(character)
            }
        }
        if !numberStack.isEmpty {
            if let number = Double(characters: numberStack) {
                arguments.append(Argument.number(value: number))
            } else {
                throw ValidationError.invalidExpression
            }
        }
        return arguments
    }
}

// MARK: - Converter error -

extension Expression {
    enum ValidationError: LocalizedError {
        case invalidExpression
        
        var errorDescription: String? {
            switch self {
            case .invalidExpression:
                return "error.invalidExpression".localized
            }
        }
    }
}

// MARK: - ValidableInterface implementation -

extension Expression: ValidableInterface {
    func validate() -> ValidationResult {
        for validator in self.validators {
            if case .failed(let error) = validator.validate(value: self.value) {
                return .failed(error: error)
            }
        }
        return .passed
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

// MARK: - Double conversion -

extension Double {
    
    // MARK: - Private properties -
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = String(NumberSymbol.dot)
        formatter.plusSign = String(OperatorSymbol.addition)
        formatter.minusSign = String(OperatorSymbol.subtraction)
        
        return formatter
    }()
    
    // MARK: - Initialization -
    
    init?(characters: [Character]) {
        guard let number = Double.numberFormatter.number(from: String(characters)) else {
            return nil
        }
        self.init(number.doubleValue)
    }
}
