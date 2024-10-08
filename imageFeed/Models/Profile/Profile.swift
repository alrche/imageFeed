//
//  Profile.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 10.08.2024.
//

import Foundation

struct Profile {
    let username: String
    let name: String
    let bio: String
    var loginName: String {
        return "@\(username)"
    }

    init(username: String, firstName: String, lastName: String, bio: String) {
        self.username = username
        self.name = "\(firstName) \(lastName)"
        self.bio = bio
    }
}
