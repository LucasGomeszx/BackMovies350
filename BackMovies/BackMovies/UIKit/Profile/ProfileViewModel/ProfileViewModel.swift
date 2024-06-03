//
//  ProfileViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 28/06/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

protocol ProfileViewModelProtocol: AnyObject {
    func didFetchUserDataSuccess(user: User)
    func didFetchUserDataFailure(error: String)
    func startLoadAnimation()
    func stopLoadAnimation()
}

class ProfileViewModel {
    
    private weak var delegate: ProfileViewModelProtocol?
    
    public func configDelegate(delegate: ProfileViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            self.delegate?.didFetchUserDataFailure(error: signOutError.localizedDescription)
        }
    }
    
    public func getUserData() {
        delegate?.startLoadAnimation()
        FirestoreManager.shared.getUserData { result in
            switch result {
            case .success(let user):
                self.delegate?.didFetchUserDataSuccess(user: user)
            case .failure(let error):
                self.delegate?.didFetchUserDataFailure(error: error.localizedDescription)
            }
        }
        
    }
    
    public func saveUserName(name: String) {
        FirestoreManager.shared.updateUserName(name: name) { result in
            switch result {
            case .success(_):
                self.getUserData()
            case .failure(let error):
                self.delegate?.didFetchUserDataFailure(error: error.localizedDescription)
            }
        }
    }
    
}
