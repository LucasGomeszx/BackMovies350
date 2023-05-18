//
//  Video.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 16/05/23.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    var results: [VideoKey]?
}

// MARK: - Result
struct VideoKey: Codable {
    var key: String?
    var type: String?
}
