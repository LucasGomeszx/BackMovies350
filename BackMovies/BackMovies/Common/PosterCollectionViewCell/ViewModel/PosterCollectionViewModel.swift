//
//  PosterCollectionViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

protocol PosterCollectionViewModelDelegate: AnyObject {
    func suss()
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
        let net = NetworkRequest(endpointURL: Api.movieDetail(id: movieId))
        service.request(net) { (result: Result<MovieDetail, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.movieDetail = success
                    self.delegate?.suss()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
}
