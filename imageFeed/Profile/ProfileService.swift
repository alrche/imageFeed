//
//  ProfileService.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 10.08.2024.
//

import Foundation

final class ProfileService {

    static let shared = ProfileService()

    private(set) var profile: Profile?
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?

    private init() {}

    func makeProfileRequest() throws -> URLRequest? {
        guard let baseUrl = Constants.defaultBaseURL else {
            throw ProfileServiceError.invalidBaseUrl
        }
        guard let url = URL(string: "/me", relativeTo: baseUrl) else {
            throw ProfileServiceError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let token = OAuth2TokenStorage().token else {
            throw ProfileServiceError.gettingTokenError
        }
        let tokenStringField = "Bearer \(token)"

        request.setValue(tokenStringField, forHTTPHeaderField: "Authorization")
        return request
    }

    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)

        guard let request = try? makeProfileRequest() else {
            completion(.failure(ProfileServiceError.invalidRequest))
            return
        }

        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let profile = Profile(
                    username: response.username,
                    firstName: response.firstName ?? "",
                    lastName: response.lastName ?? "",
                    bio: response.bio ?? ""
                )
                self.profile = profile
                ProfileImageService.shared.fetchProfileImageURL(username: response.username) { _ in }
                completion(.success(profile))
            case .failure(let error):
                print("[\(String(describing: self)).\(#function)]: \(ProfileServiceError.fetchProfileError) - Ошибка получения данных профиля, \(error.localizedDescription)")
                completion(.failure(error))
            }

            self.task = nil
        }

        self.task = task
        task.resume()
    }

    func clearProfile() {
        profile = nil
    }
}

enum ProfileServiceError: Error {
    case invalidRequest
    case invalidResponse
    case invalidBaseUrl
    case invalidUrl
    case gettingTokenError
    case fetchProfileError
}
