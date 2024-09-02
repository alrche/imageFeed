//
//  ProfileImageResult.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 10.08.2024.
//

import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}
