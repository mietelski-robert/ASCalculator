//
//  KeyboardItemStyleFactory.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

class KeyboardItemStyleFactory {
    
}

// MARK: - KeyboardItemStyleFactoryInterface implementation -

extension KeyboardItemStyleFactory: KeyboardItemStyleFactoryInterface {
    func makeOperatorStyle() -> KeyboardItem.Style {
        return KeyboardItem.Style(textFont: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light),
                                  textColor: UIColor(named: "algaeGreenColor"),
                                  backgroundColor: UIColor(named: "mintCreamColor"))
    }
    
    func makeNumberStyle() -> KeyboardItem.Style {
        return KeyboardItem.Style(textFont: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light),
                                  textColor: UIColor.darkGray,
                                  backgroundColor: UIColor.black.withAlphaComponent(0.1))
    }
    
    func makeDestructiveStyle() -> KeyboardItem.Style {
        return KeyboardItem.Style(textFont: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light),
                                  textColor: UIColor(named: "venetianRedColor"),
                                  backgroundColor: UIColor(named: "lightPinkColor"))
    }
}
