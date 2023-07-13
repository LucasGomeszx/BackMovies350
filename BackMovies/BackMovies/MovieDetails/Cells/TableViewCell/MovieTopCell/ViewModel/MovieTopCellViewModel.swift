//
//  MovieTopCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol MovieTopCellViewModelProtocol: AnyObject {
    func setheartState(isFavorite: Bool)
}

class MovieTopCellViewModel {
    
    private var movieDetail: MovieDetailModel
    private weak var delegate: MovieTopCellViewModelProtocol?
    
    init(movieDetail: MovieDetailModel, delegate: MovieTopCellViewModelProtocol) {
        self.movieDetail = movieDetail
        self.delegate = delegate
    }
    
    var posterPath: String {
        return movieDetail.movieCellModel?.posterPath ?? ""
    }
    
    var title: String {
        movieDetail.movieCellModel?.title ?? ""
    }
    
    var voteAvg: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if let voteAverage = movieDetail.movieCellModel?.voteAverage {
            return formatter.string(from: NSNumber(value: voteAverage)) ?? "0.0"
        } else {
            return "0.0"
        }
    }
    
    func getUserFavoriteMovies() {
        FirestoreManager.shared.isMovieInFavorites(movieId: movieDetail.movieCellModel?.id ?? 0) { result in
            switch result {
             case .success(let isInFavorites):
                 print("O filme está nos favoritos: \(isInFavorites)")
                self.delegate?.setheartState(isFavorite: isInFavorites)
             case .failure(let error):
                 print("Erro ao verificar se o filme está nos favoritos: \(error.localizedDescription)")
                self.delegate?.setheartState(isFavorite: false)
             }
        }
    }
    
    func addFavoriteMovie() {
        FirestoreManager.shared.addFavoriteMovie(movieId: movieDetail.movieCellModel?.id ?? 0) { result in
            switch result {
            case .success:
                print("Filme adicionado aos favoritos.")
            case .failure(let error):
                print("Erro ao adicionar filme aos favoritos no Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteFavoriteMovie() {
        FirestoreManager.shared.removeFavoriteMovie(movieId: movieDetail.movieCellModel?.id ?? 0) { result in
            switch result {
            case .success:
                print("Filme removido dos favoritos.")
            case .failure(let error):
                print("Erro ao adicionar filme aos favoritos no Firestore: \(error.localizedDescription)")
            }
        }
    }
    
}
