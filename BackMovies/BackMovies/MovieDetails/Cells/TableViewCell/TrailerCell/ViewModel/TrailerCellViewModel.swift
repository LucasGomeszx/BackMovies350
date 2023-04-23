//
//  TrailerCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

class TrailerCellViewModel {
    
    private let movie: Poster
    
    init(movie: Poster) {
        self.movie = movie
    }
    
    var getOverview: String {
        movie.overview ?? ""
    }
    
}

