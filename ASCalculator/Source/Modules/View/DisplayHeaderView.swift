//
//  DisplayHeaderView.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

class DisplayHeaderView: UICollectionReusableView {

    // MARK: - Views -
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var expressionTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    
    // MARK: - Access methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundView.layer.cornerRadius = 8.0
    }
}

// MARK: - CalculatorInteractorInterface implementation -

extension DisplayHeaderView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
