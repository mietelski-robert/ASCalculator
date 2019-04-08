//
//  KeyboardItem.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

struct KeyboardItem {

    // MARK: - Public properties -
    
    let title: String
    let style: Style
    let command: TransformationCommandInterface
    
    // MARK: - Initialization -

    init(title: String, style: Style, command: TransformationCommandInterface) {
        self.title = title
        self.style = style
        self.command = command
    }
}

// MARK: - Keyboard item style -

extension KeyboardItem {
    struct Style {
        
        // MARK: - Public properties -
        
        let textFont: UIFont
        let textColor: UIColor?
        let backgroundColor: UIColor?
        
        // MARK: - Initialization -
        
        init(textFont: UIFont, textColor: UIColor?, backgroundColor: UIColor?) {
            self.textFont = textFont
            self.textColor = textColor
            self.backgroundColor = backgroundColor
        }
    }
}
