//
//  ActorSearch.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/06/23.
//

import Foundation

// MARK: - ActorSearch
struct ActorSearch: Codable {
    var page: Int?
    var results: [ActorInfo]?
    var totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct ActorInfo: Codable {
    var id: Int?
    var name, profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePath = "profile_path"
    }
}
