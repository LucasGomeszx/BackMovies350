//
//  ProfileViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 28/06/23.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol ProfileViewModelProtocol: AnyObject {
    func didFetchUserDataSuccess(email: String, name: String)
}

class ProfileViewModel {
    
    private var auth: Auth?
    private var db: Firestore?
    private weak var delegate: ProfileViewModelProtocol?
    
    public func configDelegate(delegate: ProfileViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func getUserData() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        if let currentUser = auth?.currentUser?.uid {
            self.db?.collection("user").document(currentUser).getDocument(completion: { result, error in
                if error != nil {
                    print("Error")
                    return
                }
                if let snapshot = result?.data() {
                    self.delegate?.didFetchUserDataSuccess(email: snapshot["email"] as? String ?? "", name: snapshot["name"] as? String ?? "")
                }
                
            })
        }
        
    }
    
}
