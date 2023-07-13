//
//  RelatedCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Alamofire

protocol RelatedCellViewModelDelegate: AnyObject {
    func didFetchSimilarMovies()
    func didFailToFetchSimilarMovies()
}

class RelatedCellViewModel {
    
    private var movieDetail: MovieDetailModel?
    private var similarMovies: SimilarMovies?
    
    weak var delegate: RelatedCellViewModelDelegate?
    
    public func setUpDelegate(movieDetail: MovieDetailModel) {
        self.movieDetail = movieDetail
    }
    
    var getSimilarMoviesCount: Int {
        movieDetail?.similarMovies?.results?.count ?? 0
    }
    
    var getSimilarMovieCellSize: CGSize {
        CGSize(width: 140, height: 275)
    }
    
    public func getSimilarMovie(index: Int) -> MovieCellModel {
        movieDetail?.similarMovies?.results?[index] ?? MovieCellModel()
    }
    
    public func setMovieDetail(movieDetail: MovieDetailModel) {
        self.movieDetail = movieDetail
    }

}
