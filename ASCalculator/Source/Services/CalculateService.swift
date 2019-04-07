//
//  CalculateService.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class CalculateService {
    
    // MARK: - Public properties -
    
    let numberConverter: NumberConverter
    let postfixConverter: PostfixConverter
    
    // MARK: - Initialization -
    
    init(numberConverter: NumberConverter = NumberConverter(),
         postfixConverter: PostfixConverter = PostfixConverter()) {
        
        self.numberConverter = numberConverter
        self.postfixConverter = postfixConverter
    }
}

// MARK: - CalculateServiceInterface implementation -

extension CalculateService: CalculateServiceInterface {
    func evaluate(expression: Expression) throws -> Double {
        let infixInput = try expression.split()
        let postfixInput = self.postfixConverter.convert(infixInput: infixInput)
        
        return try self.numberConverter.calculate(postfixInput: postfixInput)
    }
}
