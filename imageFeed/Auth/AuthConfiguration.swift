//
//  AuthConfiguration.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 27.07.2024.
//

import Foundation

enum Constants {
//    static let accessKey = "_Nu5k0UOjgD7ea66I6_hzNItciqWbvGJROf4wXyxvbI"
//    static let secretKey = "0PaKqglnm34YAGrRYt_UAl5-ihvH17VZIaje958iD44"
    static let accessKey = "pzuqlAMxGgEkh0nSUuzHoyP2poy7ZDeHVOo4xz5MWzU"
    static let secretKey = "Lci1-4msIJyVXBduwCQFst3it6Z25SFabaxeZshaTaU"
//    static let accessKey = "bkl0moEA3oTXDMwPZuT26RavnIQ5XmTNedI38qH7-6A"
//    static let secretKey = "bU75WIQrk84Vd4iBxPudg0GY6fKRR4jRn0L6E2UqRVc"
//    static let accessKey = "vPRvlYOPvN4Hbf4gYXPtc-4AL0Ck3HVALlMDy8XhFXU"
//    static let secretKey = "7QyDOsf4mp34LxbJcO0hcy7sRyauEMvvhyb_IB2GWq4"
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

    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, authURLString: String, authNativeURLString: String, defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
        self.authNativeURLString = authNativeURLString
    }

    static var standard: AuthConfiguration {
        guard let defaultBaseURL = Constants.defaultBaseURL else {
            fatalError("[\(String(describing: AuthConfiguration.self)).\(#function)]: Default Base URL is nil")
        }
        return AuthConfiguration(accessKey: Constants.accessKey,
                                 secretKey: Constants.secretKey,
                                 redirectURI: Constants.redirectURI,
                                 accessScope: Constants.accessScope,
                                 authURLString: Constants.unsplashAuthorizeURLString,
                                 authNativeURLString: Constants.unsplashAuthorizeNativeURLString,
                                 defaultBaseURL: defaultBaseURL)
    }
}
