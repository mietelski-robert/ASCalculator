//
//  DisplayAttributedStringFactory.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 06.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

class DisplayAttributedStringFactory {

    // MARK: - Access methods -
    
    func makeAttributedExpression(with text: String?) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.font: UIFont.digitalFontOfSize(ofSize: 30.0),
                          NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        return makeAttributedText(with: text, attributes: attributes)
    }
 
    func makeAttributedResult(with number: Double?) -> NSAttributedString? {
        guard let number = number else {
            return nil
        }
        let attributes = [NSAttributedString.Key.font: UIFont.digitalFontOfSize(ofSize: 45.0),
                          NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        return NSAttributedString(string: "\(number)", attributes: attributes)
    }
    
    func makeAttributedError(with error: Error?) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.font: UIFont.digitalFontOfSize(ofSize: 30.0),
                          NSAttributedString.Key.foregroundColor: UIColor.red]
        
        return makeAttributedText(with: error?.localizedDescription, attributes: attributes)
    }
    
    func makeAttributedText(with text: String?, attributes: [NSAttributedString.Key: Any]) -> NSAttributedString? {
        guard let string = text else {
            return nil
        }
        return NSAttributedString(string: string, attributes: attributes)
    }
}
