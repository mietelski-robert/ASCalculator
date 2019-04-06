//
//  ASCalculatorViewInterface.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

protocol CalculatorViewInterface: ViewInterface {
    func showExpression(text: String)
    func showResult(value: Double?)
    func showError(error: Error)
    
    func reloadCalculator()
}
