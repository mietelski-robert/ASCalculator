//
//  CalculateCommand.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class CalculateCommand {

    // MARK: - Public properties -
    
    let service: CalculateServiceInterface
    
    // MARK: - Private properties -
    
    private lazy var supportedParentheses: Set<Parenthesis> = {
        return [Parenthesis(kind: .open, symbol: ParenthesisSymbol.opening, priority: Priority.low),
                Parenthesis(kind: .close, symbol: ParenthesisSymbol.closing, priority: Priority.low)]
    }()
    
    private lazy var supportedOperators: Set<Operator> = {
        return [Operator(symbol: OperatorSymbol.addition, priority: Priority.low, command: AdditionCommand()),
                Operator(symbol: OperatorSymbol.subtraction, priority: Priority.low, command: SubtractionCommand()),
                Operator(symbol: OperatorSymbol.multiplication, priority: Priority.medium, command: MultiplicationCommand()),
                Operator(symbol: OperatorSymbol.division, priority: Priority.medium, command: DivisionCommand())]
    }()
    
    // MARK: - Initialization -
    
    init(service: CalculateServiceInterface = CalculateService()) {
        self.service = service
    }
}

// MARK: - TransformationCommandInterface implementation -

extension CalculateCommand: TransformationCommandInterface {
    func execute(with pattern: String, completion: @escaping (TransformationResult) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            do {
                let expression = Expression(value: pattern,
                                            operators: self.supportedOperators,
                                            parentheses: self.supportedParentheses)
                
                let value = try self.service.evaluate(expression: expression)
                DispatchQueue.main.async {
                    completion(.number(value: value))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.error(value: error))
                }
            }
        }
    }
}
