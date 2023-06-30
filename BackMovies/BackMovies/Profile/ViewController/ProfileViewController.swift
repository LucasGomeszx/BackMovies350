//
//  ProfileViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit

enum ProfileStrings: String {
    case alertExit = "Sair"
    case alertStay = "Continuar"
    case alertMessage = "Deseja sair do BackMovies?"
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var changeImageButton: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var viewModel: ProfileViewModel = ProfileViewModel()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupView()
        viewModel.configDelegate(delegate: self)
        viewModel.getUserData()
        imagePicker.delegate = self
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        let action = UITapGestureRecognizer(target: self, action: #selector(selectImageFromGallery))
        changeImageButton.addGestureRecognizer(action)
        changeImageButton.isUserInteractionEnabled = true
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.masksToBounds = false
        profilePhoto.layer.borderColor = UIColor.black.cgColor
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
        profilePhoto.clipsToBounds = true
    }
    
    @objc func selectImageFromGallery(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tappedExitButton(_ sender: Any) {
        let logoutAction = UIAlertAction(title: ProfileStrings.alertExit.rawValue, style: .destructive) { _ in
            self.viewModel.logOut()
            self.tabBarController?.navigationController?.popViewController(animated: true)
        }
        let doNothing = UIAlertAction(title: ProfileStrings.alertStay.rawValue, style: .default)
        Alert.showAlert(on: self, withTitle: ProfileStrings.alertExit.rawValue, message: ProfileStrings.alertMessage.rawValue, actions: [doNothing,logoutAction])
    }
    
}

//MARK: - ProfileViewModelProtocol

extension ProfileViewController: ProfileViewModelProtocol {
    func didFetchUserDataSuccess(email: String, name: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
}

//MARK: - ProfileViewController
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profilePhoto.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
