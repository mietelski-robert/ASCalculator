//
//  KeyboardViewCell.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

class KeyboardViewCell: UICollectionViewCell {

    // MARK: - Views -
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    // MARK: - Public properties -
    
    override var isHighlighted: Bool {
        didSet {
            self.selectionView.isHidden = !isHighlighted
        }
    }
    
    // MARK: - Access methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let cornerRadius: CGFloat = 10.0
        
        self.wrapperView.layer.cornerRadius = cornerRadius
        self.selectionView.layer.cornerRadius = cornerRadius
    }
}
