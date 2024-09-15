//
//  AlertPresenter.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 10.08.2024.
//

import Foundation
import UIKit

protocol AlertPresenting: AnyObject {
    func showAlert(for result: AlertModel)
}

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: ((UIAlertAction) -> Void)?
    var secondButtonText: String? = nil
    var secondCompletion: ((UIAlertAction) -> Void)? = nil
}

final class AlertPresenter {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension AlertPresenter: AlertPresenting {

    func showAlert(for result: AlertModel) {
        guard let viewController = viewController else { return }

        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        let alertAction = UIAlertAction(title: result.buttonText, style: .default, handler: result.completion)
        alert.addAction(alertAction)

        if let secondButtonText = result.secondButtonText {
            let secondAction = UIAlertAction(title: secondButtonText, style: .default, handler: result.secondCompletion)
            alert.addAction(secondAction)
        }
        alert.view.accessibilityIdentifier = "Alert"

        viewController.present(alert, animated: true, completion: nil)
    }
}
