//
//  MovieDetail.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    var id: Int?
    var overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
