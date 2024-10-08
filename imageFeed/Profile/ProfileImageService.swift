//
//  ProfileImageService.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 10.08.2024.
//

import Foundation

final class ProfileImageService {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")

    private init() {}
    
    private(set) var profileImageURL: String?
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?

    func makeProfileImageRequest(username: String) throws -> URLRequest? {
        guard let baseUrl = Constants.defaultBaseURL else {
            throw ProfileImageServiceError.invalidBaseUrl
        }
        guard let url = URL(string: "/users/\(username)", relativeTo: baseUrl) else {
            throw ProfileImageServiceError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let token = OAuth2TokenStorage().token else {
            throw ProfileImageServiceError.gettingTokenError
        }
        let tokenStringField = "Bearer \(token)"

        request.setValue(tokenStringField, forHTTPHeaderField: "Authorization")
        return request
    }

    func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)

        guard let request = try? makeProfileImageRequest(username: username) else {
            completion(.failure(ProfileImageServiceError.invalidRequest))
            return
        }

        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                let profileImage = response.profileImage.large
                self.profileImageURL = profileImage
                completion(.success(profileImage))
                NotificationCenter.default.post(name: ProfileImageService.didChangeNotification,
                                                object: self,
                                                userInfo: ["URL": profileImage])
            case .failure(let error):
                print("[\(String(describing: self)).\(#function)]: \(ProfileImageServiceError.fetchProfileImageError) - Ошибка получения URL изображения профиля, \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        self.task = task
        task.resume()
    }

    func clearProfileImage() {
        profileImageURL = nil
    }
}

enum ProfileImageServiceError: Error {
    case invalidRequest
    case invalidResponse
    case invalidBaseUrl
    case invalidUrl
    case gettingTokenError
    case fetchProfileImageError
}
