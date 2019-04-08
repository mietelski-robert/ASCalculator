//
//  ASCalculatorInteractorInterface.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

protocol CalculatorInteractorInterface: InteractorInterface {
    func loadKeyboardItems(completion: @escaping ([KeyboardItem]) -> Void)
}
