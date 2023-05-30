//
//  FavoriteViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Alamofire

protocol FavoriteViewModelDelegate: AnyObject {
    func didFetchMoviesSuccess()
    func didFetchMoviesFailure()
}

class FavoriteViewModel {
    
    private var movieList: Movies?
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
        AF.request(Api.popularMovies(), method: .get).validate().responseDecodable(of: Movies.self) { response in
            switch response.result {
            case .success(let result):
                self.movieList = result
                self.delegate?.didFetchMoviesSuccess()
            case.failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
}
