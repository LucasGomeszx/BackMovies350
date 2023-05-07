//
//  MovieDetailViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/04/23.
//

import Foundation

protocol MovieDetailViewModelDelegate: AnyObject {
    func suss()
}

class MovieDetailViewModel {
    
    private var movieId: Int
    private var service: Service = Service()
    private var movieDetail: MovieDetail?
    private weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieId: Int){
        self.movieId  = movieId
    }
    
    public func setUpDelegate(delegate: MovieDetailViewModelDelegate) {
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
    
    var getTableViewCellCount: Int {
        6
    }
    
    var getMovieTopCellSize: CGFloat {
        640
    }
    
    var getTrailerCellSize: CGFloat {
        CGFloat((((movieDetail?.overview?.count ?? 10) / 2)) + 310)
    }
    
    var getWatchCellSize: CGFloat {
        220
    }
    
    var getActorCellSize: CGFloat {
        300
    }
    
    var getRelatedCell: CGFloat {
        340
    }
    
    var getMapCellSize: CGFloat {
        250
    }
    
    var getMovieDetail: MovieDetail {
        movieDetail ?? MovieDetail()
    }

    var getMovieId: Int {
        movieId
    }
    
}
