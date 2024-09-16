//
//  AuthConfiguration.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 27.07.2024.
//

import Foundation

enum Constants {
    static let accessKey = "bmydUKnIHeMKNxju7o4JSXGKomYnKukmAqIgK2Dysh4"
    static let secretKey = "OyUSnrietm-cly_WSg0NJ6X9A-Q4CJS9TZcqRtuRexE"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com/")
    static let defaultBaseURLString = "https://api.unsplash.com/"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let unsplashTokenURLString = "https://unsplash.com/oauth/token"
    static let unsplashAuthorizeNativeURLString = "/oauth/authorize/native"
}

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    let authNativeURLString: String

    static var standard: AuthConfiguration {
        guard let defaultBaseURL = Constants.defaultBaseURL else {
            fatalError("[\(String(describing: AuthConfiguration.self)).\(#function)]: Default Base URL is nil")
        }
        return AuthConfiguration(accessKey: Constants.accessKey,
                                 secretKey: Constants.secretKey,
                                 redirectURI: Constants.redirectURI,
                                 accessScope: Constants.accessScope,
                                 defaultBaseURL: defaultBaseURL,
                                 authURLString: Constants.unsplashAuthorizeURLString,
                                 authNativeURLString: Constants.unsplashAuthorizeNativeURLString)
    }
}
