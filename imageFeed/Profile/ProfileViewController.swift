//
//  ProfileViewController.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 21.07.2024.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

    private func initProfileImage (view: UIView) {
        view.backgroundColor = UIColor(named: "YP Black")
        let profileImage = UIImage(named: "profile_userpick")
        let profilePhotoView = UIImageView(image: profileImage)
        profilePhotoView.tag = 1
        view.addSubview(profilePhotoView)

        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        profilePhotoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        profilePhotoView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profilePhotoView.widthAnchor.constraint(equalToConstant: 70).isActive = true

    }

    private func initLogoutButton(view: UIView) {
        let logOutButton = UIButton.systemButton(
            with: UIImage(named: "profile_logout_button")!,
            target: self,
            action: #selector(Self.didTapLogoutButton)
        )

        logOutButton.tintColor = UIColor(named: "YP Red")
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.centerYAnchor.constraint(equalTo: view.viewWithTag(1)!
            .centerYAnchor).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
    }

    private func initLabels(view: UIView) {
        let userName = UILabel()
        userName.text = "Екатерина Новикова"
        userName.textColor = UIColor(named: "YP White")
        let boldFontSize: CGFloat = 23
        let boldFont = UIFont.systemFont(ofSize: boldFontSize, weight: .bold)
        userName.font = boldFont
        view.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo: view.viewWithTag(1)!.bottomAnchor, constant: 8).isActive = true
        userName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true

        let userNickName = UILabel()
        userNickName.text = "@ekaterina_nov"
        let regularFontSize: CGFloat = 13
        userNickName.textColor = UIColor(named: "YP White")
        let regularFont = UIFont.systemFont(ofSize: regularFontSize, weight: .regular)
        userNickName.font = regularFont
        view.addSubview(userNickName)
        userNickName.translatesAutoresizingMaskIntoConstraints = false
        userNickName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8).isActive = true
        userNickName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true

        let userDescription = UILabel()
        userDescription.text = "Hello, world!"
        userDescription.textColor = UIColor(named: "YP White")
        userDescription.font = regularFont
        view.addSubview(userDescription)
        view.addSubview(userDescription)
        userDescription.translatesAutoresizingMaskIntoConstraints = false
        userDescription.topAnchor.constraint(equalTo: userNickName.bottomAnchor, constant: 8).isActive = true
        userDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initProfileImage (view: view)
        initLogoutButton(view: view)
        initLabels(view: view)
    }

    @objc
    private func didTapLogoutButton() {
        for view in view.subviews {
            if view is UILabel {
                view.removeFromSuperview()
            } else {
                if let imageView = view as? UIImageView {
                    imageView.image = UIImage(named: "profile_stub")
                    imageView.tintColor = UIColor(named: "YP Gray")
                }
            }
        }
    }
}
