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
    func didFetchUserDataSuccess(email: String, name: String, imageUrl: String)
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
            // Deslogou com sucesso
        } catch let signOutError as NSError {
            print("Erro ao deslogar o usuário: \(signOutError.localizedDescription)")
        }
    }
    
    public func getUserData() {
        delegate?.startLoadAnimation()
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
               let email = snapshotData["email"] as? String,
               let name = snapshotData["name"] as? String,
               let image = snapshotData["imageURL"] as? String,
               let favoriteMovies = snapshotData["favoriteMovies"] as? [Any] {
                print(favoriteMovies.count)
                print(favoriteMovies)
                self.delegate?.didFetchUserDataSuccess(email: email, name: name,imageUrl: image)
            }
        }
    }
    
    func uploadImageToFirebaseStorage(_ image: UIImage) {
        delegate?.startLoadAnimation()
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Erro ao obter dados da imagem")
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
            print("Usuário não autenticado")
            return
        }

        let userRef = Firestore.firestore().collection("user").document(currentUserID)
        userRef.updateData(["imageURL": imageURL]) { error in
            if let error = error {
                print("Erro ao atualizar o link da imagem do usuário no Firestore: \(error.localizedDescription)")
                self.delegate?.stopLoadAnimation()
            } else {
                print("Link da imagem do usuário atualizado com sucesso no Firestore")
                self.delegate?.stopLoadAnimation()

            }
        }
    }
}
