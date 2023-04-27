//
//  FavoriteViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

protocol FavoriteViewModelDelegate: AnyObject {
    func suss()
}

class FavoriteViewModel {
    
    private var movieList: Movies?
    private var service: Service = Service()
    private weak var delegate: FavoriteViewModelDelegate?
    
    var getMoviesCount: Int {
        movieList?.results?.count ?? 0
    }
    
    var getMovieCellSize: CGSize {
        CGSize(width: 135, height: 260)
    }
    
    public func getMoviesId(index: Int) -> Int {
        movieList?.results?[index].id ?? 0
    }
    
    public func setUpDelegate(delegate: FavoriteViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchMovies() {
        let net = NetworkRequest(endpointURL: Api.popularMovies())
        service.request(net) { (result: Result<Movies, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.movieList = success
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
