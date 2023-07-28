//
//  ProfileViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/03/23.
//

import UIKit
import Lottie

enum ProfileStrings: String {
    case alertExit = "Sair"
    case alertError = "Erro"
    case alertCancel = "Cancelar"
    case alertStay = "Continuar"
    case alertImage = "Alterar Foto"
    case alertMessage = "Deseja sair do BackMovies?"
    case alertChangeImage = "Deseja alterar a imagem?"
    case lottieAnimationName = "registerLoad"
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tmdbLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    var viewModel: ProfileViewModel = ProfileViewModel()
    let imagePicker = UIImagePickerController()
    let lottieAnimation = LottieAnimationView(name: ProfileStrings.lottieAnimationName.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupView()
        viewModel.getUserData()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        tmdbLabel.textColor = .textColor
        loadingView.isHidden = true
        loadingView.backgroundColor = .black
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        let nameGesture = UITapGestureRecognizer(target: self, action: #selector(changeName))
        nameLabel.addGestureRecognizer(nameGesture)
        nameLabel.isUserInteractionEnabled = true
        exitButton.layer.cornerRadius = 10
    }
    
    @objc func changeName() {
        Alert.showAlertWithTextField(on: self, withTitle: "Digite algo", message: nil, textFieldPlaceholder: "Digite aqui", cancelTitle: "Cancelar", saveTitle: "Salvar", saveHandler: { text in
            if let text = text {
                if !text.hasPrefix(" ") {
                    self.viewModel.saveUserName(name: text)
                } else {
                    let trimmedText = text.trimmingCharacters(in: .whitespaces)
                    if trimmedText.isEmpty {
                        Alert.showAlert(on: self, withTitle: "Erro", message: "Digite um nome válido", actions: nil)
                    } else {
                        self.viewModel.saveUserName(name: trimmedText)
                    }
                }
            }
        })
    }
    
    @objc func selectImageFromGallery(_ sender: UIButton) {
        let logoutAction = UIAlertAction(title: ProfileStrings.alertStay.rawValue, style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let doNothing = UIAlertAction(title: ProfileStrings.alertCancel.rawValue, style: .destructive)
        Alert.showAlert(on: self, withTitle: ProfileStrings.alertImage.rawValue, message: ProfileStrings.alertChangeImage.rawValue,actions: [logoutAction,doNothing])
    }
    
    @IBAction func tappedExitButton(_ sender: Any) {
        let logoutAction = UIAlertAction(title: ProfileStrings.alertExit.rawValue, style: .destructive) { _ in
            self.viewModel.logOut()
            self.tabBarController?.navigationController?.popViewController(animated: true)
        }
        let doNothing = UIAlertAction(title: ProfileStrings.alertStay.rawValue, style: .default)
        Alert.showAlert(on: self, withTitle: ProfileStrings.alertExit.rawValue, message: ProfileStrings.alertMessage.rawValue, actions: [doNothing,logoutAction])
    }
    
    private func startLottieAnimation() {
        loadingView.addSubview(lottieAnimation)
        NSLayoutConstraint.activate([
            lottieAnimation.widthAnchor.constraint(equalToConstant: 65),
            lottieAnimation.heightAnchor.constraint(equalToConstant: 65),
            lottieAnimation.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            lottieAnimation.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()
        loadingView.isHidden = false
    }
    
    private func stopLottieAnimation() {
        lottieAnimation.stop()
        loadingView.isHidden = true
    }
    
}
