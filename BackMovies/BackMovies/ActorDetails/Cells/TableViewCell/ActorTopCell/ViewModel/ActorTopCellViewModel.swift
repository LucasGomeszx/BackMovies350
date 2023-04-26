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
        return actorDetail.biography ?? ""
    }
    
}
