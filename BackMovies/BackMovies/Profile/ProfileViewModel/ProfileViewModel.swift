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
               let image = snapshotData["imageURL"] as? String {
                self.delegate?.didFetchUserDataSuccess(email: email, name: name,imageUrl: image)
            }
        }
    }
    
    func uploadImageToFirebaseStorage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Erro ao obter dados da imagem")
            return
        }
        
        // Nome único para a imagem no Firebase Storage
        let imageName = UUID().uuidString
        
        // Referência ao local onde a imagem será armazenada no Firebase Storage
        let storageRef = Storage.storage().reference().child("profileImages/\(imageName).jpg")
        
        // Upload da imagem para o Firebase Storage
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Erro ao fazer upload da imagem: \(error.localizedDescription)")
                return
            }
            
            // Sucesso no upload da imagem
            print("Imagem enviada com sucesso para o Firebase Storage")
            
            // Recuperar a URL de download da imagem
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Erro ao obter URL de download da imagem: \(error.localizedDescription)")
                    return
                }
                
                if let downloadURL = url?.absoluteString {
                    // Atualizar os dados do usuário no Firestore com o link da imagem
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
            } else {
                print("Link da imagem do usuário atualizado com sucesso no Firestore")
            }
        }
    }


    
}
