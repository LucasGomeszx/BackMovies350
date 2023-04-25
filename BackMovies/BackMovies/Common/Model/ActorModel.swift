//
//  ActorModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation

struct ActorModel: Codable {
    var biography, birthday: String?
    var gender, id: Int?
    var knownForDepartment, name, placeOfBirth, profilePath: String?

    enum CodingKeys: String, CodingKey {
        case biography, birthday, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
    }
}
