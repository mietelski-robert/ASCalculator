//
//  ASCalculatorPresenter.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import Foundation

class CalculatorPresenter {

    // MARK: - Public properties -
    
    var keyboardItems: [KeyboardItem] = [] {
        didSet {
            self.view?.reloadCalculator()
        }
    }
    var expression: String = "" {
        didSet {
            self.view?.showExpression(text: expression)
        }
    }
    var result: Double? {
        didSet {
            self.view?.showResult(value: result)
        }
    }
    
    // MARK: - Private properties -
    
    private weak var view: CalculatorViewInterface?
    private weak var wireframe: CalculatorWireframeInterface?
    private var interactor: CalculatorInteractorInterface
    
    // MARK: - Initialization -
    
    init(view: CalculatorViewInterface?,
         wireframe: CalculatorWireframeInterface?,
         interactor: CalculatorInteractorInterface) {
        
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

// MARK: - CalculatorPresenterInterface implementation -

extension CalculatorPresenter: CalculatorPresenterInterface {
    func viewDidLoad() {
        self.interactor.loadKeyboardItems { [weak self] items in
            self?.keyboardItems = items
        }
    }
    
    func didSelectKeyboardItem(at index: Int) {
        let item = self.keyboardItems[index]
        
        item.command.execute(with: self.expression) { [weak self] result in
            switch result {
            case .expression(let value):
                self?.expression = value
                self?.result = nil
            case .number(let value):
                self?.result = value
            case .error(let value):
                self?.view?.showError(error: value)
            }
        }
    }
}
