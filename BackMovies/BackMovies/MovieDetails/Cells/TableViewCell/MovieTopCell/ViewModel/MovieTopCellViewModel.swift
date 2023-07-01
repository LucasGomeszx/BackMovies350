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
    func setheartState()
}

class MovieTopCellViewModel {
    
    private var movieDetail: MovieDetail
    private var favoriteMovies: [Int] = []
    private weak var delegate: MovieTopCellViewModelProtocol?
    
    init(movieDetail: MovieDetail, delegate: MovieTopCellViewModelProtocol) {
        self.movieDetail = movieDetail
        self.delegate = delegate
    }
    
    var posterPath: String {
        return movieDetail.posterPath ?? ""
    }
    
    var title: String {
        movieDetail.title ?? ""
    }
    
    var voteAvg: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if let voteAverage = movieDetail.voteAverage {
            return formatter.string(from: NSNumber(value: voteAverage)) ?? "0.0"
        } else {
            return "0.0"
        }
    }
    
    func getUserFavoriteMovies() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Usuário não autenticado")
            return
        }

        Firestore.firestore().collection("user").document(currentUserID).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }

            if let error = error {
                print("Erro ao obter os dados do usuário: \(error.localizedDescription)")
                return
            }

            if let snapshotData = snapshot?.data(),
               let favoriteMovies = snapshotData["favoriteMovies"] as? [Int] {
                self.favoriteMovies = favoriteMovies
                self.delegate?.setheartState()
            }
        }
    }
    
    func verifiFavoriteMovie() -> String {
        if favoriteMovies.contains(movieDetail.id ?? 0){
            return "heart.fill"
        }else {
            return "heart"
        }
    }
    
    func saveFavoriteMovie() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return
        }
        let userRef = Firestore.firestore().collection("user").document(currentUserID)
        userRef.updateData(["favoriteMovies": self.favoriteMovies]) { error in
            if let error = error {
                print("Erro ao atualizar filmes do usuário no Firestore: \(error.localizedDescription)")
            } else {
                print("Dados Atualizados.")
            }
        }
    }
    
    func addFavoriteMovie() {
        self.favoriteMovies.append(movieDetail.id ?? 0)
        saveFavoriteMovie()
    }
    
    func deleteFavoriteMovie() {
        favoriteMovies.removeAll { $0 == movieDetail.id ?? 0 }
        saveFavoriteMovie()
    }
    
}
