//
//  ActorMoviesViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation
import Alamofire

class ActorMoviesViewModel {
    
    private var actorModel: ActorModel?
    
    public func setUpViewModel(actorModel: ActorModel) {
        self.actorModel = actorModel
    }

    var getActorMoviesCount: Int {
        actorModel?.listMovies?.cast?.count ?? 0
    }
    
    public func getActorMovies(index: Int) -> MovieCellModel {
        actorModel?.listMovies?.cast?[index] ?? MovieCellModel()
    }
    
    var getActorMoviesCellSize: CGSize {
        CGSize(width: 140, height: 260)
    }
    
}
