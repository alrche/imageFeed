//
//  URLSession+data.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 10.08.2024.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
}

extension URLSession {
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionTask {
        let fulfillCompletionOnTheMainThread: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let data = data, let response = response, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200 ..< 300 ~= statusCode {
                    fulfillCompletionOnTheMainThread(.success(data))
                } else {
                    print("[URLSession.data]: NetworkError: HTTP status code: \(statusCode)")
                    fulfillCompletionOnTheMainThread(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error = error {
                print("[URLSession.data]: NetworkError: \(error.localizedDescription)")
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlRequestError(error)))
            } else {
                print("[URLSession.data]: NetworkError: URLSession error")
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlSessionError))
            }
        })

        return task
    }
}

extension URLSession {
    func objectTask<T: Decodable> (
        for request: URLRequest,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) -> URLSessionTask {
        let decoder = JSONDecoder()

        let task = data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let object = try decoder.decode(T.self, from: data)
                    completionHandler(.success(object))
                } catch {
                    print("[URLSession.objectTask]: Ошибка декодирования \(error.localizedDescription) - Данные: \(String(data: data, encoding: .utf8) ?? "")")

                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        return task
    }
}
