//
//  ASCalculatorWireframe.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

class CalculatorWireframe {
 
    // MARK: - Public properties -

    let viewController: UIViewController
    
    // MARK: - Private properties -
    
    private let storyboard = UIStoryboard(name: "Calculator", bundle: nil)
    
    // MARK: - Initialization -
    
    init() throws {
        guard let viewController: CalculatorViewController = self.storyboard.instantiateViewController() else {
            throw WireframeError.loadingViewFailed
        }
        self.viewController = viewController
        
        let keyboardItemFactory = KeyboardItemFactory(styleFactory: KeyboardItemStyleFactory())
        let interactor = CalculatorInteractor(factory: keyboardItemFactory)
        viewController.presenter = CalculatorPresenter(view: viewController,
                                                       wireframe: self,
                                                       interactor: interactor)
    }
}

// MARK: - Errors -

extension CalculatorWireframe {
    enum WireframeError: LocalizedError {
        case loadingViewFailed
        
        var errorDescription: String? {
            switch self {
            case .loadingViewFailed:
                return "error.loadingViewFailed".localized
            }
        }
    }
}

// MARK: - CalculatorWireframeInterface implementation -

extension CalculatorWireframe: CalculatorWireframeInterface {
    
}
