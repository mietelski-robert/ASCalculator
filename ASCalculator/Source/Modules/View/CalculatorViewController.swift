//
//  ASCalculatorViewController.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: - Views -
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public properties -
    
    var presenter: CalculatorPresenterInterface?
    
    // MARK: - Private properties -
    
    private var calculatorDisplayView: DisplayHeaderView? {
        let headers = self.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)
        return headers.first as? DisplayHeaderView
    }
    
    private let factory = DisplayAttributedStringFactory()
    private let numberOfItemsInLine = 4
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        self.setupCollectionView()
        self.presenter?.viewDidLoad()
    }
}

// MARK: - Reuse identifier -

extension CalculatorViewController {
    private struct ReuseIdentifier {
        static let KeyboardViewCell = "KeyboardViewCellIdentifier"
        static let DisplayHeaderView = "DisplayHeaderViewIdentifier"
    }
}

// MARK: - View setup -

extension CalculatorViewController {
    private func setupNavigationBar() {
        self.title = "calculator.view.title".localized
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "KeyboardViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: ReuseIdentifier.KeyboardViewCell)
        self.collectionView.register(UINib(nibName: "DisplayHeaderView", bundle: nil),
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: ReuseIdentifier.DisplayHeaderView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

// MARK: - Size calculations -

extension CalculatorViewController {
    private func keyboardItemSize(for collectionView: UICollectionView,
                                  collectionViewFlowLayout: UICollectionViewFlowLayout) -> CGSize {
        
        let sectionInsets = collectionViewFlowLayout.sectionInset
        let minimumInteritemSpacing = collectionViewFlowLayout.minimumInteritemSpacing
        
        let contentSize = collectionView.bounds.inset(by: sectionInsets).size
        let interitemsSpacing = CGFloat(self.numberOfItemsInLine - 1) * minimumInteritemSpacing
        
        let dimension = (contentSize.width - interitemsSpacing) / CGFloat(self.numberOfItemsInLine)
        return CGSize(width: dimension, height: dimension)
    }
    
    private func displaySize(for collectionView: UICollectionView,
                             collectionViewFlowLayout: UICollectionViewFlowLayout) -> CGSize {
        
        let sectionInsets = collectionViewFlowLayout.sectionInset
        let minimumLineSpacing = collectionViewFlowLayout.minimumLineSpacing
        
        let contentSize = collectionView.bounds.inset(by: sectionInsets).size
        let numberOfItems = self.presenter?.keyboardItems.count ?? 0
        let numberOfLines = Int(ceil(CGFloat(numberOfItems) / CGFloat(self.numberOfItemsInLine)))
        let linesSpacing = CGFloat(numberOfLines - 1) * minimumLineSpacing
        let itemSize = self.keyboardItemSize(for: collectionView, collectionViewFlowLayout: collectionViewFlowLayout)
        
        let height = contentSize.height - (linesSpacing + (itemSize.height * CGFloat(numberOfLines)))
        return CGSize(width: contentSize.width, height: height)
    }
}

// MARK: - UICollectionViewDelegate implementation -

extension CalculatorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let collectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        return self.keyboardItemSize(for: collectionView, collectionViewFlowLayout: collectionViewFlowLayout)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let collectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        return self.displaySize(for: collectionView, collectionViewFlowLayout: collectionViewFlowLayout)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.presenter?.didSelectKeyboardItem(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource implementation -

extension CalculatorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.keyboardItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ReuseIdentifier.DisplayHeaderView,
                                                                         for: indexPath)
        if let displayHeaderView = headerView as? DisplayHeaderView {
            let attributedExpression = self.factory.makeAttributedExpression(with: self.presenter?.expression)
            let attributedResult = self.factory.makeAttributedResult(with: self.presenter?.result)
            
            displayHeaderView.expressionTextField.attributedText = attributedExpression
            displayHeaderView.resultTextField.attributedText = attributedResult
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.KeyboardViewCell, for: indexPath)
        
        if let keyboardCell = cell as? KeyboardViewCell, let item = self.presenter?.keyboardItems[indexPath.row] {
            keyboardCell.titleLabel.text = item.title
            keyboardCell.titleLabel.font = item.style.textFont
            keyboardCell.titleLabel.textColor = item.style.textColor
            keyboardCell.wrapperView.backgroundColor = item.style.backgroundColor
        }
        return cell
    }
}

// MARK: - CalculatorViewInterface implementation -

extension CalculatorViewController: CalculatorViewInterface {
    func showExpression(text: String) {
        let attributedExpression = self.factory.makeAttributedExpression(with: text)
        self.calculatorDisplayView?.expressionTextField.attributedText = attributedExpression
    }
    
    func showResult(value: Double?) {
        let attributedResult = self.factory.makeAttributedResult(with: value)
        self.calculatorDisplayView?.resultTextField.attributedText = attributedResult
    }
    
    func showError(error: Error) {
        let attributedError = self.factory.makeAttributedError(with: error)
        self.calculatorDisplayView?.resultTextField.attributedText = attributedError
    }
    
    func reloadCalculator() {
        self.collectionView.reloadData()
    }
}
