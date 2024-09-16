//
//  ProfileViewControllerSpy.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

@testable import imageFeed
import Foundation

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ProfileViewPresenterProtocol?

    var updateProfileDetailsCalled: Bool = false
    var updateProfileImageCalled: Bool = false

    func updateProfileDetails(profile: imageFeed.Profile?) {
        updateProfileDetailsCalled = true
    }

    func updateProfileImage(url: URL?) {
        updateProfileImageCalled = true
    }
}
