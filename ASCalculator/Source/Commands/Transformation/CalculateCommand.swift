//
//  CalculateCommand.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class CalculateCommand {

}

// MARK: - TransformationCommandInterface implementation -

extension CalculateCommand: TransformationCommandInterface {
    func execute(with pattern: String, completion: @escaping (TransformationResult) -> Void) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                completion(.number(value: 100))
            }
        }
    }
}
