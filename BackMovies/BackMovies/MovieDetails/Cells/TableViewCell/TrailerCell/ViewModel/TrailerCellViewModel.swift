//
//  TrailerCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

class TrailerCellViewModel {
    
    private let movieDetail: MovieDetail
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    var getOverview: String {
        movieDetail.overview ?? ""
    }
    
}

