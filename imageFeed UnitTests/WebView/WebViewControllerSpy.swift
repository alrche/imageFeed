//
//  WebViewControllerSpy.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

import imageFeed
import Foundation

final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
    var presenter: imageFeed.WebViewPresenterProtocol?

    var loadRequestCalled: Bool = false

    func load(request: URLRequest) {
        loadRequestCalled = true
    }

    func setProgressValue(_ newValue: Float) {

    }

    func setProgressHidden(_ isHidden: Bool) {

    }
}
