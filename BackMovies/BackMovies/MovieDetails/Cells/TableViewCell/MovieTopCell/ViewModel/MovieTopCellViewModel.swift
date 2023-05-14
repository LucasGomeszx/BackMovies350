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
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if let voteAverage = movieDetail.voteAverage {
            return formatter.string(from: NSNumber(value: voteAverage)) ?? "0.0"
        } else {
            return "0.0"
        }
    }
    
}
