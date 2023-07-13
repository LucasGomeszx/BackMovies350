//
//  ActorModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation

struct ActorModel: Codable {
    var biography: String?
    var birthday: String?
    var gender: Int?
    var id: Int?
    var knownForDepartment: String?
    var name: String?
    var placeOfBirth: String?
    var profilePath: String?
    var listMovies: ActorMovies?
    var actorSocialMedia: ActorSocialMedia?

    enum CodingKeys: String, CodingKey {
        case biography, birthday, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
    }
}
