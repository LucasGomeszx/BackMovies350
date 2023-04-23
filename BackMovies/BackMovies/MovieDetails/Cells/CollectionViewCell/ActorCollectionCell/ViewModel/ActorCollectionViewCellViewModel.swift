//
//  ActorCollectionViewCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

class ActorCollectionViewCellViewModel {
    
    private let actor: Cast
    
    init(actor: Cast) {
        self.actor = actor
    }
    
    var getActorName: String {
        actor.name ?? ""
    }
    
    var getActorCharacter: String {
        actor.character ?? ""
    }
    
    var getActorProfilePath: String {
        actor.profilePath ?? ""
    }
    
}
