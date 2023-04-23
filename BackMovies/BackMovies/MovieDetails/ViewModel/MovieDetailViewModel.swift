//
//  MovieDetailViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/04/23.
//

import Foundation

class MovieDetailViewModel {
    
    private var poster: Poster
    
    init(poster: Poster){
        self.poster  = poster
    }
    
    var getMovie: Poster {
        poster
    }
    
    var getMovieId: Int {
        poster.id ?? 0
    }
    
}
