//
//  NumberSymbol.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

struct NumberSymbol {
    static let zero: Character = "0"
    static let one: Character = "1"
    static let two: Character = "2"
    static let three: Character = "3"
    static let four: Character = "4"
    static let five: Character = "5"
    static let six: Character = "6"
    static let seven: Character = "7"
    static let eight: Character = "8"
    static let nine: Character = "9"
    static let dot: Character = "."
    
    static let digitSymbols: Set<Character> = [zero, one, two, three, four, five, six, seven, eight, nine]
    static let allSymbols: Set<Character> = digitSymbols.union([dot])
}
