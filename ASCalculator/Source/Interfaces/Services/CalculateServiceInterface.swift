//
//  CalculateServiceInterface.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

protocol CalculateServiceInterface: class {
    func evaluate(expression: Expression) throws -> Double
}
