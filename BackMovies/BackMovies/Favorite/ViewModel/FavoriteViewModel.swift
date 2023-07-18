//
//  FavoriteViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Alamofire
import Firebase
import FirebaseFirestore

protocol FavoriteViewModelDelegate: AnyObject {
    func didFetchMoviesSuccess()
    func didFetchMoviesFailure()
    func didFetchError(error: String)
}

class FavoriteViewModel {
    
    private var movieList: [MovieCellModel] = []
    private var favoriteMoviesListener: ListenerRegistration?
    private weak var delegate: FavoriteViewModelDelegate?
    
    var getMoviesCount: Int {
        if movieList.count == 0 {
            return 1
        } else {
            return movieList.count
        }
    }
    
    var getMovieCellSize: CGSize {
        CGSize(width: 135, height: 260)
    }
    
    public func getMoviesId(index: Int) -> MovieCellModel {
        movieList[index]
    }
    
    public func setUpDelegate(delegate: FavoriteViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func startFavoriteMoviesListener() {
        favoriteMoviesListener = FirestoreManager.shared.observeFavoriteMovies { result in
            switch result {
            case .success(let favoriteMovies):
                self.movieList = favoriteMovies
                self.delegate?.didFetchMoviesSuccess()
            case .failure(let error):
                self.delegate?.didFetchError(error: error.localizedDescription)
            }
        }
    }
    
    public func isArrayEmpty() -> Bool {
        if movieList.count == 0 {
            return true
        }else {
            return false
        }
    }
    
}
