//
//  OAuth2TokenStorage.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 27.07.2024.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: "bearerToken")
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: "bearerToken")
            }
        }
    }
    
    static func deleteToken() -> Bool {
        KeychainWrapper.standard.removeObject(forKey: "bearerToken")
    }
}
