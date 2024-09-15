//
//  ProfileViewPresenterSpy.swift
//  imageFeed UnitTests
//
//  Created by Aliaksandr Charnyshou on 14.09.2024.
//

import imageFeed
import Foundation

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol?

    var addNotificationCalled: Bool = false
    var updateProfileCalled: Bool = false
    var updateAvatarCalled: Bool = false
    var logoutProfileCalled: Bool = false

    func addNotification() {
        addNotificationCalled = true
    }

    func updateProfile() {
        updateProfileCalled = true
    }

    func updateAvatar() {
        updateAvatarCalled = true
    }

    func logoutProfile() {
        logoutProfileCalled = true
    }
}
