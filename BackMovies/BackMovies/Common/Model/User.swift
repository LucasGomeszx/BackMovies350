//
//  User.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 02/07/23.
//

import Foundation

struct User: Codable {
    var id: String?
    var name: String?
    var email: String?
    var imageUrl: String?
    var favoriteMovies: [Int]?
}
