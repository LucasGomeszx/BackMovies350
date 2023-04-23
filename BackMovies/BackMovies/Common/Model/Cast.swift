//
//  Cast.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 23/04/23.
//

import Foundation

// MARK: - Elenco
struct Elenco: Codable {
    var id: Int?
    var cast: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    var id: Int?
    var name: String?
    var profilePath: String?
    var character: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
    }
}

