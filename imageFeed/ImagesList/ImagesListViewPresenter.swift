//
//  ImagesListViewPresenter.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

import UIKit
import Kingfisher

protocol ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath)
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListViewPresenter: ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    private let imageListService = ImageListService.shared

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        guard let thumbUmageURL = self.view?.photos[indexPath.item].thumbImageURL else { return }
        guard let url = URL(string: thumbUmageURL) else { return }
        let imageView = UIImageView()
        let processor = RoundCornerImageProcessor(cornerRadius: 8)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url,
                              placeholder: .none,
                              options: [.processor(processor)]) { result in
            switch result {
            case .success(_):

                var textDate = ""
                if let date = self.view?.photos[indexPath.item].createdAt {
                    textDate = self.dateFormatter.string(from: date)
                }

                cell.updateCell(
                    cellDataLabelTitle: textDate,
                    likeButtonTitle: "",
                    imageView: imageView
                )
                self.view?.tableView.reloadRows(at: [indexPath], with: .automatic)

            case .failure(let error):
                let logMessage =
                """
                [\(String(describing: self)).\(#function)]:
                \(ImageListServiceError.fetchImageError) - Ошибка получения изображения ячейки таблицы, \(error.localizedDescription)
                """
                print(logMessage)
            }
        }

        guard let isLiked = self.view?.photos[indexPath.item].isLiked else { return }
        cell.setIsLiked(isLiked: isLiked)
    }

    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = self.view?.tableView.indexPath(for: cell)  else { return }
        guard let photo = self.view?.photos[indexPath.row] else { return }

        UIBlockingProgressHUD.show()

        imageListService.changeLike(photoId: photo.id, isLiked: photo.isLiked) { result in
            UIBlockingProgressHUD.dismiss()
            switch result {
            case .success:
                self.view?.photos = self.imageListService.photos
                guard let isLiked = self.view?.photos[indexPath.row].isLiked else { return }
                cell.setIsLiked(isLiked: isLiked)
            case .failure:
                self.view?.showLikeAlert()
            }
        }
    }
}
