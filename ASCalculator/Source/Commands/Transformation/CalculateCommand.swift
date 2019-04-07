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
    let supportedValidators: [ValidatorInterface]
    
    // MARK: - Private properties -
    
    private lazy var supportedParentheses: Set<Parenthesis> = {
        return [Parenthesis(kind: .open, symbol: ParenthesisSymbol.opening, priority: 0),
                Parenthesis(kind: .close, symbol: ParenthesisSymbol.closing, priority: 0)]
    }()
    
    private lazy var supportedOperators: Set<Operator> = {
        return [Operator(symbol: OperatorSymbol.addition, priority: 0, command: AdditionCommand()),
                Operator(symbol: OperatorSymbol.subtraction, priority: 0, command: SubtractionCommand()),
                Operator(symbol: OperatorSymbol.multiplication, priority: 1, command: MultiplicationCommand()),
                Operator(symbol: OperatorSymbol.division, priority: 1, command: DivisionCommand())]
    }()
    
    // MARK: - Initialization -
    
    init(service: CalculateServiceInterface = CalculateService()) {
        self.service = service
        self.supportedValidators = []
    }
}

// MARK: - TransformationCommandInterface implementation -

extension CalculateCommand: TransformationCommandInterface {
    func execute(with pattern: String, completion: @escaping (TransformationResult) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            let expression = Expression(value: pattern,
                                        operators: self.supportedOperators,
                                        parentheses: self.supportedParentheses,
                                        validators: self.supportedValidators)
            
            switch expression.validate() {
            case .passed:
                do {
                    let value = try self.service.evaluate(expression: expression)
                    DispatchQueue.main.async {
                        completion(.number(value: value))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.error(value: error))
                    }
                }
            case .failed(let error):
                DispatchQueue.main.async {
                    completion(.error(value: error))
                }
            }
        }
    }
}
