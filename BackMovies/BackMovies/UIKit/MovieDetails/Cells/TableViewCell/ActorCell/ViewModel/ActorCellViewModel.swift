//
//  ActorCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Alamofire

class ActorCellViewModel {
    
    private var movieDetail: MovieDetailModel?
    
    public func setUpViewModel(movieDetail: MovieDetailModel) {
        self.movieDetail = movieDetail
    }
    
    public func getCast(index: Int) -> Cast {
        return movieDetail?.movieCast?.cast?[index] ?? Cast()
    }
    
    public func getCastId(index: Int) -> Int {
        movieDetail?.movieCast?.cast?[index].id ?? 0
    }
    
    var getActorCount: Int {
        movieDetail?.movieCast?.cast?.count ?? 0
    }
    
    var getCellSize: CGSize {
        CGSize(width: 125, height: 275)
    }

}
