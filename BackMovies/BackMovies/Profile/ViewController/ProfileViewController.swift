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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        imageToCircle()
        viewModel.configDelegate(delegate: self)
        viewModel.getUserData()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func imageToCircle() {
            profilePhoto.layer.borderWidth = 1
            profilePhoto.layer.masksToBounds = false
            profilePhoto.layer.borderColor = UIColor.black.cgColor
            profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
            profilePhoto.clipsToBounds = true
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
