//
//  imageFeed_UITests.swift
//  imageFeed UITests
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

import XCTest

final class imageFeed_UITests: XCTestCase {
    private let app = XCUIApplication()

    enum TestCredentials {
          static let email = "alr.chernyshev@yandex.ru"
          static let password = "Alex_3299885!"
          static let fullName = "Aliaksandr Charnyshou"
          static let login = "@alrche"
        }

    override func setUpWithError() throws {
        continueAfterFailure = true

        app.launch()
    }

    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        let webView = app.webViews["UnsplashWebView"]

        XCTAssertTrue(webView.waitForExistence(timeout: 5))

        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))

        loginTextField.tap()
        loginTextField.typeText(TestCredentials.email)
        app.toolbars["Toolbar"].buttons["Done"].tap()

        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))

        passwordTextField.tap()
        passwordTextField.typeText(TestCredentials.password)
        app.toolbars["Toolbar"].buttons["Done"].tap()

        webView.buttons["Login"].tap()

        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)

        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }

    func testFeed() throws {
        sleep(5)
        let tablesQuery = app.tables

        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()

        sleep(2)

        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)

        cellToLike.buttons["like_button_off"].tap()
        cellToLike.buttons["like_button_on"].tap()

        sleep(2)

        cellToLike.tap()

        sleep(2)

        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)

        let navBackButtonWhiteButton = app.buttons["backward_button"]
        navBackButtonWhiteButton.tap()
    }

    func testProfile() throws {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()

        XCTAssertTrue(app.staticTexts[TestCredentials.fullName].exists)
        XCTAssertTrue(app.staticTexts[TestCredentials.login].exists)

        app.buttons["logout_button"].tap()

        app.alerts["Alert"].scrollViews.otherElements.buttons["Да"].tap()
    }
}
