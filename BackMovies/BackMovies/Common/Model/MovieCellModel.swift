//
//  MovieCellModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 11/07/23.
//

import Foundation

struct MovieCellModel: Codable {
    var id: Int?
    var overview, posterPath, title: String?
    var voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, overview
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
    }
}
