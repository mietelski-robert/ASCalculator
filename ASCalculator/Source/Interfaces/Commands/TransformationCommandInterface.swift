//
//  TransformationCommandInterface.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

enum TransformationResult {
    case expression(value: String)
    case number(value: Double)
    case error(value: Error)
}

extension TransformationResult: Equatable {
    static func == (lhs: TransformationResult, rhs: TransformationResult) -> Bool {
        switch (lhs, rhs) {
        case let (.expression(a), .expression(b)):
            return a == b
        case let (.number(a), .number(b)):
            return a == b
        case let (.error(a), .error(b)):
            return a.localizedDescription == b.localizedDescription
        default:
            return false
        }
    }
}

protocol TransformationCommandInterface: class {
    func execute(with pattern: String, completion: @escaping (TransformationResult) -> Void)
}
