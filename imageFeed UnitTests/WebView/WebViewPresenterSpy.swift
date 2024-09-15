//
//  WebViewPresenterSpy.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

import imageFeed
import Foundation

final class WebViewPresenterSpy: WebViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var view: WebViewViewControllerProtocol?

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func didUpdateProgressValue(_ newValue: Double) {
        
    }

    func code(from url: URL) -> String? {
        return nil
    }
}
