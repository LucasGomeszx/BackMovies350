//
//  ActorSocialMedia.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 20/06/23.
//

import Foundation

// MARK: - ActorSocialMedia
struct ActorSocialMedia: Codable {
    var facebookID, instagramID, tiktokID, twitterID: String?

    enum CodingKeys: String, CodingKey {
        case facebookID = "facebook_id"
        case instagramID = "instagram_id"
        case tiktokID = "tiktok_id"
        case twitterID = "twitter_id"
    }
}
