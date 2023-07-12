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
    
    private var movieId: Int?
    private var similarMovies: SimilarMovies?
    
    weak var delegate: RelatedCellViewModelDelegate?
    
    public func setUpDelegate(delegate: RelatedCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    var getSimilarMoviesCount: Int {
        similarMovies?.similarMovies?.results?.count ?? 0
    }
    
    var getSimilarMovieCellSize: CGSize {
        CGSize(width: 140, height: 275)
    }
    
    public func getSimilarMovieId(index: Int) -> MovieCellModel {
        similarMovies?.similarMovies?.results?[index] ?? MovieCellModel()
    }
    
    public func setMovieId(id: Int) {
        movieId = id
    }
    
    public func fetchSimilar() {
        ServiceManeger.shared.fetchSimilarMovies(movieId: movieId ?? 0) { result in
            switch result {
            case .success(let success):
                self.similarMovies = success
                self.delegate?.didFetchSimilarMovies()
            case .failure(_):
                self.delegate?.didFailToFetchSimilarMovies()
            }
        }
    }
    
}
