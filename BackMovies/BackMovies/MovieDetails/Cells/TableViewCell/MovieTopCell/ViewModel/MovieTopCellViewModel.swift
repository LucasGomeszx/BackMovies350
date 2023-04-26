//
//  MovieTopCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

class MovieTopCellViewModel {
    
    private var movieDetail: MovieDetail
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    var posterPath: String {
        return movieDetail.posterPath ?? ""
    }
    
    var title: String {
        movieDetail.title ?? ""
    }
    
    var voteAvg: String {
        return String(movieDetail.voteAverage ?? 0)
    }
    
}
