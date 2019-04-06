//
//  UIViewController+Extensions.swift
//  ASCalculator
//
//  Created by Robert Mietelski on 05.04.2019.
//  Copyright © 2019 Robert Mietelski. All rights reserved.
//

import UIKit

struct DialogButtonIndex {
    static let cancel: Int? = nil
}

extension UIViewController {
    func showDialog(title: String? = nil,
                    message: String,
                    cancelButtonTitle: String? = nil,
                    otherButtonTitles: [String] = [],
                    presentBlock: (() -> Void)? = nil,
                    dismissBlock: ((Int?) -> Void)? = nil) {
        
        let alertController = self.alertController(title: title,
                                                   message: message,
                                                   cancelButtonTitle: cancelButtonTitle,
                                                   otherButtonTitles: otherButtonTitles,
                                                   dismissBlock: dismissBlock)
        
        self.present(alertController, animated: true, completion: presentBlock)
    }
}

extension UIViewController: ErrorDialogInterface {
    func showErrorDialog(with error: Error, presentBlock: (() -> Void)?, dismissBlock: (() -> Void)?) {
        self.showDialog(title: "error.title".localized,
                        message: error.localizedDescription,
                        cancelButtonTitle: "ok".localized,
                        presentBlock: presentBlock,
                        dismissBlock: { _ in dismissBlock?() })
    }
}

private extension UIViewController {
    func alertController(title: String?,
                         message: String,
                         cancelButtonTitle: String? = nil,
                         otherButtonTitles: [String],
                         dismissBlock: ((Int?) -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        if let title = cancelButtonTitle {
            alertController.addAction(UIAlertAction(title: title,
                                                    style: .cancel,
                                                    handler: { _ in dismissBlock?(DialogButtonIndex.cancel) } ))
        }
        
        for (index, otherButtonTitle) in otherButtonTitles.enumerated()  {
            let action = UIAlertAction(title: otherButtonTitle,
                                       style: .default,
                                       handler: { (action) in
                                        dismissBlock?(index)
            })
            alertController.addAction(action)
        }
        return alertController
    }
}
