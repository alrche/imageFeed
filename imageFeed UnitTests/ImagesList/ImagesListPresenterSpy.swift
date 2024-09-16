//
//  ImagesListPresenterSpy.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 15.09.2024.
//

@testable import imageFeed
import Foundation

final class ImagesListPresenterSpy: ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol?

    var configCellCalled: Bool = false
    var imageListCellDidTapLikeCalled: Bool = false

    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        configCellCalled = true
    }

    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        imageListCellDidTapLikeCalled = true
    }
}
