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
}

class FavoriteViewModel {
    
    private var movieList: [Int] = []
    private var favoriteMoviesListener: ListenerRegistration?
    private weak var delegate: FavoriteViewModelDelegate?
    
    var getMoviesCount: Int {
        movieList.count
    }
    
    var getMovieCellSize: CGSize {
        CGSize(width: 135, height: 260)
    }
    
    public func getMoviesId(index: Int) -> Int {
        movieList[index]
    }
    
    public func setUpDelegate(delegate: FavoriteViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func startFavoriteMoviesListener() {
        movieList.removeAll()
        
        favoriteMoviesListener = FirestoreManager.shared.observeFavoriteMovies { result in
            switch result {
            case .success(let favoriteMovies):
                self.movieList = favoriteMovies
                self.delegate?.didFetchMoviesSuccess()
            case .failure(_):
                self.delegate?.didFetchMoviesFailure()
            }
        }
    }
    
    public func deInitListener() {
        favoriteMoviesListener?.remove()
    }
    
}
