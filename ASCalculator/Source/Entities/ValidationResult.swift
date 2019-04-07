//
//  ValidationResult.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

enum ValidationResult {
    case passed
    case failed(error: Error)
}

extension ValidationResult: Equatable {
    static func ==(lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        switch (lhs, rhs) {
        case let (.failed(a), .failed(b)):
            return a.localizedDescription == b.localizedDescription
        case (.passed, .passed):
            return true
        default:
            return false
        }
    }
}
