//
//  PosterCollectionViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Alamofire

protocol PosterCollectionViewModelDelegate: AnyObject {
    func didFetchMovieDetailSuccess()
}

class PosterCollectionViewModel {
    
    private var movieId: Int
    private var service: Service = Service()
    private var movieDetail: MovieDetail?
    private weak var delegate: PosterCollectionViewModelDelegate?
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    var getMovieDetailName: String {
        movieDetail?.title ?? ""
    }
    
    var getMovieDetailPoster: String {
        movieDetail?.posterPath ?? ""
    }
    
    public func setUpDelegate(delegate: PosterCollectionViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchMovieDetail() {
        ServiceManeger.shared.fetchPosterCell(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.movieDetail = success
                self.delegate?.didFetchMovieDetailSuccess()
            case .failure(_):
                break
            }
        }
    }
    
}
