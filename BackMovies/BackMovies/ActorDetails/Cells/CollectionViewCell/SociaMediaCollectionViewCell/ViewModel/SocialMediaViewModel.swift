//
//  SocialMediaViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation

class SocialMediaViewModel {
    
    private var socialMedia: SocialMedia
    
    init(socialMedia: SocialMedia) {
        self.socialMedia = socialMedia
    }
    
    var getSocialMediaImage: String {
        socialMedia.socialMediaType ?? ""
    }
    
    var getSocialMediaName: String {
        guard let social = socialMedia.socialMediaType  else {return ""}
        switch social {
        case "facebook":
            return socialMedia.actorSocialMedia ?? ""
        case "instagram":
            return socialMedia.actorSocialMedia ?? ""
        case "tiktok":
            return socialMedia.actorSocialMedia ?? ""
        case "twitter":
            return socialMedia.actorSocialMedia ?? ""
        default:
            return ""
        }
    }
    
}
