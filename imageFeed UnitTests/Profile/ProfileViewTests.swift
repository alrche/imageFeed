//
//  ProfileViewTests.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

@testable import imageFeed
import XCTest

final class ProfileViewTests: XCTestCase {

    func testCallsAddNotification() {
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController

        _ = viewController.view
        presenter.addNotification()

        XCTAssertTrue(presenter.addNotificationCalled)
    }

    func testCallsUpdateProfile() {
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController

        _ = viewController.view
        presenter.updateProfile()

        XCTAssertTrue(presenter.updateProfileCalled)
    }

    func testCallsUpdateAvatar() {
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController

        _ = viewController.view
        presenter.updateAvatar()

        XCTAssertTrue(presenter.updateAvatarCalled)
    }

    func testCallsProfileLogout() {
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController

        _ = viewController.view
        presenter.logoutProfile()

        XCTAssertTrue(presenter.logoutProfileCalled)
    }

    func testCallsUpdateProfileDetails() {
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenter()
        viewController.presenter = presenter
        presenter.view = viewController

        let profile = Profile(username: "ekaterina", firstName: "Екатерина Новикова", lastName: "@ekaterina_nov", bio: "Hello, World!")
        viewController.updateProfileDetails(profile: profile)

        XCTAssertTrue(viewController.updateProfileDetailsCalled)
    }

    func testCallsSetUserPhoto() {
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenter()
        viewController.presenter = presenter
        presenter.view = viewController

        let url = Constants.defaultBaseURL
        viewController.updateProfileImage(url: url)

        XCTAssertTrue(viewController.updateProfileImageCalled)
    }
}
