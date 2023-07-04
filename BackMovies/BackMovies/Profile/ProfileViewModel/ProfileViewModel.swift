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
            print("Deslogou")
        } catch let signOutError as NSError {
            print("Erro ao deslogar o usuário: \(signOutError.localizedDescription)")
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
    
    func uploadImageToFirebaseStorage(_ image: UIImage) {
        delegate?.startLoadAnimation()
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let imageName = UUID().uuidString
        
        let storageRef = Storage.storage().reference().child("profileImages/\(imageName).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Erro ao fazer upload da imagem: \(error.localizedDescription)")
                return
            }
            
            print("Imagem enviada com sucesso para o Firebase Storage")

            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Erro ao obter URL de download da imagem: \(error.localizedDescription)")
                    return
                }
                
                if let downloadURL = url?.absoluteString {
                    self.updateUserImageURL(downloadURL)
                }
            }
        }
    }

    private func updateUserImageURL(_ imageURL: String) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return
        }

        let userRef = Firestore.firestore().collection("user").document(currentUserID)
        userRef.updateData(["imageUrl": imageURL]) { error in
            if let error = error {
                print("Erro ao atualizar o link da imagem do usuário no Firestore: \(error.localizedDescription)")
                self.delegate?.stopLoadAnimation()
            } else {
                self.delegate?.stopLoadAnimation()

            }
        }
    }
}
