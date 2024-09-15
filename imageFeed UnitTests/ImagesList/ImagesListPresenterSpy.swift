//
//  ImagesListPresenterSpy.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 15.09.2024.
//

import imageFeed
import Foundation

final class ImagesListPresenterSpy: ImagesListViewPresenterProtocol {
    var view: (any imageFeed.ImagesListViewControllerProtocol)?

    var configCellCalled: Bool = false
    var imageListCellDidTapLikeCalled: Bool = false

    func configCell(for cell: imageFeed.ImagesListCell, with indexPath: IndexPath) {
        configCellCalled = true
    }

    func imageListCellDidTapLike(_ cell: imageFeed.ImagesListCell) {
        imageListCellDidTapLikeCalled = true
    }
}
