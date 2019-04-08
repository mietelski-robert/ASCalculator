//
//  Parenthesis.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

struct Parenthesis: Hashable {
    
    // MARK: - Public properties -
    
    let kind: Kind
    let symbol: Character
    let priority: Int
    
    // MARK: - Initialization -
    
    init(kind: Kind, symbol: Character, priority: Int) {
        self.kind = kind
        self.symbol = symbol
        self.priority = priority
    }
}

extension Parenthesis {
    enum Kind: Int {
        case open, close
    }
}
