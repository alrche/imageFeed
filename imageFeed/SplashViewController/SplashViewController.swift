//
//  SplashViewController.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 27.07.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash_screen_logo")
        return imageView
    }()
    
    private let profileService = ProfileService.shared
    private let oauth2Service = OAuth2Service.shared
    private let tokenStorage = OAuth2TokenStorage()
    private var alertPresenter: AlertPresenter?
    private var isEntered = false

    var delegate: AuthViewControllerDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        checkAuthStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        alertPresenter = AlertPresenter(viewController: self)
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .ypBlack
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 75.0),
            logoImageView.heightAnchor.constraint(equalToConstant: 77.68)
        ])
    }

    private func checkAuthStatus() {
        guard !isEntered else { return }
        isEntered = true
        if oauth2Service.isAuthenticated {
            UIBlockingProgressHUD.show()

            if let token = tokenStorage.token {
                fetchProfile(token: token)
            }
            UIBlockingProgressHUD.dismiss()
            self.switchToTabBarController()
        } else {
            showAuthViewController()
        }
    }

    private func showLoginAlert(error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let alertModel = AlertModel(
                title: "Что-то пошло не так :(",
                message: "Не удалось войти в систему: \(error.localizedDescription)",
                buttonText: "Ok") { [weak self] _ in
                    guard let self = self else { return }
                    self.isEntered = false
                    guard OAuth2TokenStorage.deleteToken() else {
                        assertionFailure("Cannot remove token")
                        return
                    }
                    self.checkAuthStatus()
                }
            self.alertPresenter?.showAlert(for: alertModel)
        }
    }

    private func showAuthViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AuthViewController")
        guard let viewController = viewController as? AuthViewController else { return }
        viewController.delegate = self
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { return }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func didAuntenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true) 
        if let token = tokenStorage.token {
            fetchProfile(token: token)
        }
    }

    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    
    private func fetchProfile(token: String) {
        UIBlockingProgressHUD.show()
        
        profileService.fetchProfile(token) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                ProfileImageService.shared.fetchProfileImageURL(
                    username: profile.username) { _ in }
                UIBlockingProgressHUD.dismiss()
                switchToTabBarController()
            case .failure(let error):
                print("[\(String(describing: self)).\(#function)]: \(AuthServiceError.invalidResponse) - Ошибка получения данных профиля, \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        UIBlockingProgressHUD.show()
        
        oauth2Service.fetchOAuthToken(code: code) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            
            guard let self = self else { return }
            
            switch result {
            case .success:
                guard let token = tokenStorage.token else { return }
                fetchProfile(token: token)
            case .failure(let error):
                print("[\(String(describing: self)).\(#function)]: \(AuthServiceError.invalidResponse) - Ошибка получения OAuth токена, \(error.localizedDescription)")

                self.showLoginAlert(error: error)
            }
        }
        
    }
}
