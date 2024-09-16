//
//  ImagesListViewTests.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 15.09.2024.
//

@testable import imageFeed
import XCTest

final class ImagesListViewTests: XCTestCase {
    
    func testViewControllerCallsConfigCell() {
        let viewController = ImagesListViewController()
        let presenter = ImagesListPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        let cell = ImagesListCell()
        let tableView = viewController.tableView
        guard let indexPath = viewController.tableView.indexPath(for: cell) else { return }

        _ = viewController.tableView(tableView, cellForRowAt: indexPath)

        XCTAssertTrue(presenter.configCellCalled)
    }

    func testViewControllerCallsImageListCellDidTapLike() {
        let viewController = ImagesListViewController()
        let presenter = ImagesListPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        let cell = ImagesListCell()
        let tableView = viewController.tableView
        guard let indexPath = viewController.tableView.indexPath(for: cell) else { return }
        
        _ = viewController.view
        presenter.imageListCellDidTapLike(cell)

        XCTAssertTrue(presenter.imageListCellDidTapLikeCalled)
    }
}
