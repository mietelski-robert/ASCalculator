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
    
    let postfixReslover: PostfixReslover
    let postfixConverter: PostfixConverter
    
    // MARK: - Initialization -
    
    init(postfixReslover: PostfixReslover = PostfixReslover(),
         postfixConverter: PostfixConverter = PostfixConverter()) {
        
        self.postfixReslover = postfixReslover
        self.postfixConverter = postfixConverter
    }
}

// MARK: - CalculateServiceInterface implementation -

extension CalculateService: CalculateServiceInterface {
    func evaluate(expression: Expression) throws -> Double {
        let infixInput = try ExpressionSplitter(expression: expression).split()
        let postfixInput = self.postfixConverter.convert(infixInput: infixInput)
        
        return try self.postfixReslover.resolve(postfixInput: postfixInput)
    }
}
