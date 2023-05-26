//
//  ActorTopCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation

class ActorTopCellViewModel {
    
    private var actorDetail: ActorModel
    
    init(actorDetail: ActorModel) {
        self.actorDetail = actorDetail
    }
    
    var getAtorImage: String {
        actorDetail.profilePath ?? ""
    }
    
    var getActorName: String {
        actorDetail.name ?? ""
    }
    
    var getActorBio: String {
        guard let bio = actorDetail.biography else {return "Biografia indisponivel"}
        
        if bio == "" {
            return "Biografia indisponivel"
        } else {
            return bio
        }
    }
    
}
