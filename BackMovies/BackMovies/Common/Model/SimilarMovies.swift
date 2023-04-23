//
//  SimilarMovies.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 23/04/23.
//

import Foundation

// MARK: - SimilarMovies
struct SimilarMovies: Codable {
    var page: Int?
    var results: [Poster]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

