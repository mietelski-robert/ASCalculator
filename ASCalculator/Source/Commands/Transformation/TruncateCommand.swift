//
//  TruncateCommand.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class TruncateCommand {
    
    // MARK: - Public properties -
    
    let numberOfCharacter: Int
    
    // MARK: - Initialization -
    
    init(numberOfCharacter: Int) {
        self.numberOfCharacter = numberOfCharacter
    }
}

// MARK: - Predefined number of character -

extension TruncateCommand {
    static let expressionLength = -1
}

// MARK: - TransformationCommandInterface implementation -

extension TruncateCommand: TransformationCommandInterface {
    func execute(with pattern: String, completion: @escaping (TransformationResult) -> Void) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                let result: String
                
                if self.numberOfCharacter == TruncateCommand.expressionLength {
                    result = ""
                } else {
                    result = String(pattern.dropLast(self.numberOfCharacter))
                }
                completion(.expression(value: result))
            }
        }
    }
}
