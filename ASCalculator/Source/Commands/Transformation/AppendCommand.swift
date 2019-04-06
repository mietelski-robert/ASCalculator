//
//  AppendCommand.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class AppendCommand {

    // MARK: - Public properties -
    
    let value: String
    
    // MARK: - Initialization -
    
    init(value: String) {
        self.value = value
    }
}

// MARK: - TransformationCommandInterface implementation -

extension AppendCommand: TransformationCommandInterface {
    func execute(with pattern: String, completion: @escaping (TransformationResult) -> Void) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                completion(.expression(value: pattern + self.value))
            }
        }
    }
}
