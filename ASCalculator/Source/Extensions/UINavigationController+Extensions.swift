//
//  UINavigationController+Extensions.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

extension UINavigationController {
    func pushWireframe(_ wireframe: WireframeInterface, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: WireframeInterface, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}
