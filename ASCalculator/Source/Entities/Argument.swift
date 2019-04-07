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
}
