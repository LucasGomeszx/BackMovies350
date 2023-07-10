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
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    var viewModel: ProfileViewModel = ProfileViewModel()
    let imagePicker = UIImagePickerController()
    let lottieAnimation = LottieAnimationView(name: ProfileStrings.lottieAnimationName.rawValue)
    
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
        loadingView.isHidden = true
        loadingView.backgroundColor = .black
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        let action = UITapGestureRecognizer(target: self, action: #selector(selectImageFromGallery))
        profilePhoto.addGestureRecognizer(action)
        profilePhoto.isUserInteractionEnabled = true
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.masksToBounds = false
        profilePhoto.layer.borderColor = UIColor.black.cgColor
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
        profilePhoto.clipsToBounds = true
        let nameGesture = UITapGestureRecognizer(target: self, action: #selector(changeName))
        nameLabel.addGestureRecognizer(nameGesture)
        nameLabel.isUserInteractionEnabled = true
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
    
    @IBAction func tappedInfoButton(_ sender: Any) {
        let vc: InfoViewController? = UIStoryboard(name: "InfoViewController", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
        present(vc ?? UIViewController(), animated: true)
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

//MARK: - ProfileViewModelProtocol

extension ProfileViewController: ProfileViewModelProtocol {
    func didFetchUserDataSuccess(user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        guard let url = URL(string: user.imageUrl ?? "") else {return self.stopLottieAnimation()}
        profilePhoto.loadImageFromURL(url) { result in
            switch result {
            case .success(let Image):
                self.profilePhoto.image = Image
                self.stopLottieAnimation()
            case .failure(_):
                self.stopLottieAnimation()
            }
        }
    }
    
    func didFetchUserDataFailure(error: String) {
        Alert.showAlert(on: self, withTitle: ProfileStrings.alertError.rawValue, message: error, actions: nil)
    }
    
    func startLoadAnimation() {
        startLottieAnimation()
    }
    
    func stopLoadAnimation() {
        stopLottieAnimation()
    }
}

//MARK: - ProfileViewController
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            viewModel.uploadImageToFirebaseStorage(selectedImage)
            profilePhoto.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
