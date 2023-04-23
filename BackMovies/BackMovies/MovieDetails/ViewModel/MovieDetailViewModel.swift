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
    
    var getTableViewCellCount: Int {
        6
    }
    
    var getMovieTopCellSize: CGFloat {
        623
    }
    
    var getTrailerCellSize: CGFloat {
        CGFloat((((poster.overview?.count ?? 10) / 2)) + 310)
    }
    
    var getWatchCellSize: CGFloat {
        220
    }
    
    var getActorCellSize: CGFloat {
        300
    }
    
    var getRelatedCell: CGFloat {
        270
    }
    
    var getMapCellSize: CGFloat {
        250
    }
    
    var getMovie: Poster {
        poster
    }
    
    var getMovieId: Int {
        poster.id ?? 0
    }
    
}
