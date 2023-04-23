//
//  MovieTopCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

class MovieTopCellViewModel {
    
    private var movie: Poster
    
    init(movie: Poster) {
        self.movie = movie
    }
    
    var posterPath: String {
        return movie.posterPath ?? ""
    }
    
    var title: String {
        movie.title ?? ""
    }
    
    var voteAvg: String {
        return String(movie.voteAverage ?? 0)
    }
    
}
