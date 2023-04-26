//
//  ActorMoviesViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 24/04/23.
//

import Foundation

class ActorMoviesViewModel {
    
    private var actorMovies: [Int] = [1,2,3,4,5,6,7,8,9]
    
    var getActorMoviesCount: Int {
        actorMovies.count
    }
    
    var getActorMoviesCellSize: CGSize {
        CGSize(width: 140, height: 260)
    }
    
}
