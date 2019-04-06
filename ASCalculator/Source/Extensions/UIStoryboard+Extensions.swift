//
//  UIStoryboard+Extensions.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(withIdentifier identifier: String? = nil) -> T? {
        guard let identifier = identifier else {
            return instantiateViewController(withIdentifier: String(describing: T.self)) as? T
        }
        return instantiateViewController(withIdentifier: identifier) as? T
    }
}
