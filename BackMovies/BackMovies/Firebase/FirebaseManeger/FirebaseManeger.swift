//
//  FirebaseManeger.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 02/07/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

fileprivate enum CollectionKeys: String {
    case user = "user"
}

class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private let firestore: Firestore
    
    private init() {
        firestore = Firestore.firestore()
    }
    
    private var currentUserID: String {
        guard let userId = Auth.auth().currentUser?.uid else { return ""}
        return userId
    }
    
    func createUser(name: String, email: String, completion: @escaping (Error?) -> Void) {
        let user = User(id: currentUserID, name: name, email: email, imageUrl: "", favoriteMovies: [])
        let userCollection = firestore.collection(CollectionKeys.user.rawValue)
        do {
            try userCollection.document(currentUserID).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func createUser(email: String, completion: @escaping (Error?) -> Void) {
        let userCollection = firestore.collection(CollectionKeys.user.rawValue)
        let userRef = userCollection.document(currentUserID)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                completion(nil)
            } else {
                let user = User(id: self.currentUserID, name: self.currentUserID, email: email, imageUrl: "", favoriteMovies: [])
                
                do {
                    try userRef.setData(from: user)
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            }
        }
    }
    
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        firestore.collection(CollectionKeys.user.rawValue).document(currentUserID).getDocument { document, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Documento não existe ou houve um erro"])))
                return
            }
            
            do {
                let user = try document.data(as: User.self)
                completion(.success(user))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func updateUserName(name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        userRef.updateData(["name": name]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func addFavoriteMovie(movieId: MovieCellModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        let myMovie: [String: Any] = [
            "id" : movieId.id ?? 0,
            "overview" : movieId.overview ?? "",
            "posterPath" : movieId.posterPath ?? 0,
            "title" : movieId.title ?? 0,
            "voteAverage" : movieId.voteAverage ?? 0.0
        ]
        userRef.updateData(["favoriteMovies": FieldValue.arrayUnion([myMovie])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func removeFavoriteMovie(movieId: MovieCellModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        let myMovie: [String: Any] = [
            "id" : movieId.id ?? 0,
            "overview" : movieId.overview ?? "",
            "posterPath" : movieId.posterPath ?? "",
            "title" : movieId.title ?? "",
            "voteAverage" : movieId.voteAverage ?? 0.0
        ]
        userRef.updateData(["favoriteMovies": FieldValue.arrayRemove([myMovie])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func isMovieInFavorites(movieId: MovieCellModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"])))
            return
        }
        
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, let data = document.data(), let favoriteMovies = data["favoriteMovies"] as? [[String: Any]] {
                let movieIDs = favoriteMovies.compactMap { $0["id"] as? Int }
                completion(.success(movieIDs.contains(movieId.id ?? 0)))
            } else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Não foi possível obter os dados do usuário"])))
            }
        }
    }
    
    func observeFavoriteMovies(completion: @escaping (Result<[MovieCellModel], Error>) -> Void) -> ListenerRegistration? {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"])))
            return nil
        }
        
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        return userRef.addSnapshotListener { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, let data = document.data(), let favoriteMoviesData = data["favoriteMovies"] as? [[String: Any]] {
                let favoriteMovies: [MovieCellModel] = favoriteMoviesData.compactMap { movieData in
                    guard let id = movieData["id"] as? Int,
                          let title = movieData["title"] as? String,
                          let overview = movieData["overview"] as? String,
                          let posterPath = movieData["posterPath"] as? String,
                          let voteAverage = movieData["voteAverage"] as? Double else {
                        return nil
                    }
                    
                    return MovieCellModel(id: id, overview: overview, posterPath: posterPath, title: title, voteAverage: voteAverage)
                }
                
                completion(.success(favoriteMovies))
            } else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Não foi possível obter os dados do usuário"])))
            }
        }
    }
    
}
