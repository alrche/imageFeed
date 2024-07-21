//
//  ImagesListCell.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 20.07.2024.
//

import Foundation
import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"

    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
}
