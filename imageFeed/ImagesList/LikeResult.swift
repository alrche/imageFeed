//
//  LikeResult.swift
//  imageFeed
//
//  Created by Aliaksandr Charnyshou on 31.08.2024.
//

import Foundation

struct LikeResult: Codable {
    
    let photo: PhotoResult
    let user: ProfileResult
}
