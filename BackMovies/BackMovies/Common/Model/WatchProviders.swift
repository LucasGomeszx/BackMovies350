//
//  WatchProviders.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 17/06/23.
//

import Foundation

// MARK: - WatchProviders
struct WatchProviders: Codable {
    var id: Int?
    var results: Country?
}

// MARK: - Results
struct Country: Codable {
    var br: Br?

    enum CodingKeys: String, CodingKey {
        case br = "BR"
    }
}

// MARK: - Br
struct Br: Codable {
    var flatrate: [Flatrate]?
}

// MARK: - Flatrate
struct Flatrate: Codable {
    var logoPath: String?
    var providerID: Int?
    var providerName: String?

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
    }
}
