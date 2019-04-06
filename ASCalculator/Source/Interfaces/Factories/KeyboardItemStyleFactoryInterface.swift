//
//  KeyboardItemStyleFactoryInterface.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

protocol KeyboardItemStyleFactoryInterface: class {
    func makeOperatorStyle() -> KeyboardItem.Style
    func makeNumberStyle() -> KeyboardItem.Style
    func makeDestructiveStyle() -> KeyboardItem.Style
}
