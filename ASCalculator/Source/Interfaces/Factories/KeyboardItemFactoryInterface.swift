//
//  KeyboardItemFactoryInterface.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

protocol KeyboardItemFactoryInterface: class {
    func makeClearItem(with title: String) -> KeyboardItem
    func makeDeleteItem(with title: String) -> KeyboardItem
    func makeNumberItem(with title: String) -> KeyboardItem
    func makeOperatorItem(with title: String) -> KeyboardItem
    func makeCalculateItem(with title: String) -> KeyboardItem
}

extension KeyboardItemFactoryInterface {
    func makeKeyboardItems() -> [KeyboardItem] {
        return [self.makeClearItem(with: "C"),
                self.makeDeleteItem(with: "<"),
                self.makeOperatorItem(with: String(ParenthesisSymbol.opening)),
                self.makeOperatorItem(with: String(ParenthesisSymbol.closing)),
                
                self.makeNumberItem(with: String(NumberSymbol.seven)),
                self.makeNumberItem(with: String(NumberSymbol.eight)),
                self.makeNumberItem(with: String(NumberSymbol.nine)),
                self.makeOperatorItem(with: String(OperatorSymbol.division)),
                
                self.makeNumberItem(with: String(NumberSymbol.four)),
                self.makeNumberItem(with: String(NumberSymbol.five)),
                self.makeNumberItem(with: String(NumberSymbol.six)),
                self.makeOperatorItem(with: String(OperatorSymbol.multiplication)),
                
                self.makeNumberItem(with: String(NumberSymbol.one)),
                self.makeNumberItem(with: String(NumberSymbol.two)),
                self.makeNumberItem(with: String(NumberSymbol.three)),
                self.makeOperatorItem(with: String(OperatorSymbol.subtraction)),
                
                self.makeNumberItem(with: String(NumberSymbol.dot)),
                self.makeNumberItem(with: String(NumberSymbol.zero)),
                self.makeCalculateItem(with: String(OperatorSymbol.assignment)),
                self.makeOperatorItem(with: String(OperatorSymbol.addition))]
    }
}
