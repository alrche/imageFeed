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
    let completion: (() -> Void)?
}

final class AlertPresenter {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension AlertPresenter: AlertPresenting {

    func showAlert(for result: AlertModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        let alertAction = UIAlertAction(title: result.buttonText, style: .default) { _ in
            result.completion?()
        }
        alert.addAction(alertAction)

        if var topController = UIApplication.shared.windows[0].rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true)
        }
    }
}
