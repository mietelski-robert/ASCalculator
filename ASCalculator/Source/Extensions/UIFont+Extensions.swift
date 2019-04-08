//
//  UIFont+Extensions.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 08.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

extension UIFont {
    static func digitalFontOfSize(ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Digital-7", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
    
    static func digitalItalicFontOfSize(ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Digital-7Italic", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
}
