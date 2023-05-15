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
        guard let over = movieDetail.overview else {return "Sinopse indisponivel"}
        
        if over == "" {
            return "Sinopse indisponivel"
        } else {
            return over
        }
    }
    
}

