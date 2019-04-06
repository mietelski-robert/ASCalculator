//
//  KeyboardItemFactory.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class KeyboardItemFactory {
    
    // MARK: - Public properties -
    
    let styleFactory: KeyboardItemStyleFactoryInterface
    
    // MARK: - Initialization -
    
    init(styleFactory: KeyboardItemStyleFactoryInterface) {
        self.styleFactory = styleFactory
    }
}

// MARK: - KeyboardItemFactoryInterface implementation -

extension KeyboardItemFactory: KeyboardItemFactoryInterface {
    func makeClearItem(with title: String) -> KeyboardItem {
        return KeyboardItem(title: title,
                            style: self.styleFactory.makeDestructiveStyle(),
                            command: TruncateCommand(numberOfCharacter: TruncateCommand.expressionLength))
    }
    
    func makeDeleteItem(with title: String) -> KeyboardItem {
        return KeyboardItem(title: title,
                            style: self.styleFactory.makeDestructiveStyle(),
                            command: TruncateCommand(numberOfCharacter: 1))
    }
    
    func makeNumberItem(with title: String) -> KeyboardItem {
        return KeyboardItem(title: title,
                            style: self.styleFactory.makeNumberStyle(),
                            command: AppendCommand(value: title))
    }
    
    func makeOperatorItem(with title: String) -> KeyboardItem {
        return KeyboardItem(title: title,
                            style: self.styleFactory.makeOperatorStyle(),
                            command: AppendCommand(value: title))
    }
    
    func makeCalculateItem(with title: String) -> KeyboardItem {
        return KeyboardItem(title: title,
                            style: self.styleFactory.makeOperatorStyle(),
                            command: CalculateCommand())
    }
}
