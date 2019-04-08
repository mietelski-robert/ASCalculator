//
//  ASCalculatorPresenterInterface.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

protocol CalculatorPresenterInterface: PresenterInterface {
    var keyboardItems: [KeyboardItem] { get }
    var expression: String { get }
    var result: Double? { get }
    
    func didSelectKeyboardItem(at index: Int)
}
