//
//  ProfileViewPresenter.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

import Foundation
import UIKit
import Kingfisher
import WebKit

public protocol ProfileViewPresenterProtocol:  AnyObject {
    var view: ProfileViewControllerProtocol? { get set }
    func addNotification()
    func updateProfile()
    func updateAvatar()
    func logoutProfile()
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    weak var view: ProfileViewControllerProtocol?


    private var profileImageServiceObserver: NSObjectProtocol?
    private let profileService = ProfileService.shared
    private let profileLogoutService = ProfileLogoutService.shared


    func addNotification() {
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            updateAvatar()
        }
    }

    func updateProfile() {
        guard let profile = ProfileService.shared.profile else { return }
        view?.updateProfileDetails(profile: profile)
    }

    func updateAvatar() {
        guard let profileImageURL = ProfileImageService.shared.profileImageURL,
              let url = URL(string: profileImageURL) else { return }
        view?.updateProfileImage(url: url)
    }

    func logoutProfile() {
        profileLogoutService.logout()
    }
}
