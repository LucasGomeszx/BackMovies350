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
                print(user)
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func addFavoriteMovie(movieId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
         let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
         userRef.updateData(["favoriteMovies": FieldValue.arrayUnion([movieId])]) { error in
             if let error = error {
                 completion(.failure(error))
             } else {
                 completion(.success(()))
             }
         }
     }
    
    func removeFavoriteMovie(movieId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"])))
            return
        }
        
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        userRef.updateData(["favoriteMovies": FieldValue.arrayRemove([movieId])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func isMovieInFavorites(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"])))
            return
        }
        
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, let data = document.data(), let favoriteMovies = data["favoriteMovies"] as? [Int] {
                completion(.success(favoriteMovies.contains(movieId)))
            } else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Não foi possível obter os dados do usuário"])))
            }
        }
    }
    
    func observeFavoriteMovies(completion: @escaping (Result<[Int], Error>) -> Void) -> ListenerRegistration? {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"])))
            return nil
        }
        
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        return userRef.addSnapshotListener { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, let data = document.data(), let favoriteMovies = data["favoriteMovies"] as? [Int] {
                completion(.success(favoriteMovies))
            } else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Não foi possível obter os dados do usuário"])))
            }
        }
    }

    
}

