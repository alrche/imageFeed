//
//  Constants.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 27.07.2024.
//

import Foundation

enum Constants {
    static let accessKey = "bkl0moEA3oTXDMwPZuT26RavnIQ5XmTNedI38qH7-6A"
    static let secretKey = "bU75WIQrk84Vd4iBxPudg0GY6fKRR4jRn0L6E2UqRVc"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com/")
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let unsplashTokenURLString = "https://unsplash.com/oauth/token"
    static let unsplashAuthorizeNativeURLString = "/oauth/authorize/native"
}
