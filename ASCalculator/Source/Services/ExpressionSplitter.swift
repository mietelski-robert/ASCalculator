//
//  ExpressionSplitter.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 07.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class ExpressionSplitter {

    // MARK: - Public properties -
    
    let expression: Expression
    
    // MARK: - Private properties -
    
    private var parenthesisStack = [Parenthesis]()
    private var operatorStack = [Operator]()
    private var numberStack = [Character]()
    private var arguments = [Argument]()
    
    // MARK: - Initialization -
    
    init(expression: Expression) {
        self.expression = expression
    }
    
    // MARK: - Access methods -
    
    func split() throws -> [Argument] {
        for character in self.expression.value {
            let expression = Expression(value: String(character),
                                        operators: self.expression.operators,
                                        parentheses: self.expression.parentheses)
            
            if let currentParenthesis = Parenthesis(expression: expression) {
                try self.load(parenthesis: currentParenthesis)
            } else if let currentOperator = Operator(expression: expression) {
                try self.load(operator: currentOperator)
            } else if Double(characters: [character]) != nil {
                try self.load(number: character)
            } else {
                try self.load(character: character)
            }
        }
        if !self.numberStack.isEmpty {
            if let number = Double(characters: self.numberStack) {
                self.arguments.append(Argument.number(value: number))
            } else {
                throw ValidationError.invalidExpression
            }
        }
        return self.arguments
    }
    
    // MARK: - Access methods -
    
    private func load(parenthesis currentParenthesis: Parenthesis) throws {
        switch currentParenthesis.kind {
        case .open:
            if let lastOperator = self.operatorStack.last {
                self.arguments.append(Argument.operator(value: lastOperator))
                self.operatorStack.removeLast()
            } else if !self.numberStack.isEmpty {
                throw ValidationError.invalidExpression
            }
            self.arguments.append(Argument.parenthesis(value: currentParenthesis))
            self.parenthesisStack.append(currentParenthesis)
        case .close:
            if let lastParenthesis = self.parenthesisStack.last,
                lastParenthesis.priority == currentParenthesis.priority,
                self.operatorStack.isEmpty, !self.numberStack.isEmpty {
                
                if let number = Double(characters: self.numberStack) {
                    self.arguments.append(Argument.number(value: number))
                    self.numberStack.removeAll()
                } else {
                    throw ValidationError.invalidExpression
                }
                self.arguments.append(Argument.parenthesis(value: currentParenthesis))
                self.parenthesisStack.removeLast()
            } else {
                throw ValidationError.invalidExpression
            }
        }
    }
    
    private func load(operator currentOperator: Operator) throws {
        if let lastOperator = self.operatorStack.last {
            if (currentOperator.priority != Priority.low && currentOperator.priority == lastOperator.priority) || // **, //
                currentOperator.priority > lastOperator.priority || // +*, -/
                self.operatorStack.count > 1 {
                throw ValidationError.invalidExpression
            } else {
                self.numberStack.append(currentOperator.symbol)
            }
        } else {
            if !self.numberStack.isEmpty {
                if let number = Double(characters: self.numberStack) {
                    self.arguments.append(Argument.number(value: number))
                    self.numberStack.removeAll()
                    self.operatorStack.append(currentOperator)
                } else {
                    throw ValidationError.invalidExpression
                }
            } else if self.arguments.isEmpty && currentOperator.priority == Priority.low {
                if currentOperator.symbol == OperatorSymbol.subtraction {
                    self.numberStack.append(currentOperator.symbol)
                }
            } else if !self.arguments.isEmpty {
                self.operatorStack.append(currentOperator)
            } else {
                throw ValidationError.invalidExpression
            }
        }
    }
    
    private func load(number character: Character) throws {
        if let lastOperator = self.operatorStack.last {
            self.arguments.append(Argument.operator(value: lastOperator))
            self.operatorStack.removeLast()
        }
        self.numberStack.append(character)
    }
    
    private func load(character: Character) throws {
        if character == NumberSymbol.dot {
            if self.numberStack.contains(character) {
                throw ValidationError.invalidExpression
            }
            self.numberStack.append(character)
        } else {
            throw ValidationError.invalidExpression
        }
    }
}

// MARK: - Converter error -

extension ExpressionSplitter {
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
