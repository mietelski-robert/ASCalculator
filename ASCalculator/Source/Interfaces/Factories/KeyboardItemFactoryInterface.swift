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
                self.makeOperatorItem(with: "("),
                self.makeOperatorItem(with: ")"),
                
                self.makeNumberItem(with: "7"),
                self.makeNumberItem(with: "8"),
                self.makeNumberItem(with: "9"),
                self.makeOperatorItem(with: "÷"),
                
                self.makeNumberItem(with: "4"),
                self.makeNumberItem(with: "5"),
                self.makeNumberItem(with: "6"),
                self.makeOperatorItem(with: "x"),
                
                self.makeNumberItem(with: "1"),
                self.makeNumberItem(with: "2"),
                self.makeNumberItem(with: "3"),
                self.makeOperatorItem(with: "-"),
                
                self.makeNumberItem(with: "."),
                self.makeNumberItem(with: "0"),
                self.makeCalculateItem(with: "="),
                self.makeOperatorItem(with: "+")]
    }
}
