//
//  ASCalculatorInteractor.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class CalculatorInteractor {
    
    // MARK: - Private properties -
    
    private let factory: KeyboardItemFactoryInterface
    
    // MARK: - Initialization -
    
    init(factory: KeyboardItemFactoryInterface) {
        self.factory = factory
    }
}

// MARK: - CalculatorInteractorInterface implementation -

extension CalculatorInteractor: CalculatorInteractorInterface {
    func loadKeyboardItems(completion: @escaping ([KeyboardItem]) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let items = self?.factory.makeKeyboardItems() ?? []
            
            DispatchQueue.main.async {
                completion(items)
            }
        }
    }
}
