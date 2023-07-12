//
//  PosterMovies.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/04/23.
//

import Foundation

// MARK: - Movies
struct MoviesModel: Codable {
    var page: Int?
    var results: [MovieCellModel]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
