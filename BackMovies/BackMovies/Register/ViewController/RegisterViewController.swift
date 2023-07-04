//
//  RegisterViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 09/03/23.
//

import Foundation
import UIKit
import Lottie

enum RegisterStrings: String {
    case nameLabel = "Nome"
    case emailLabel = "E-mail"
    case password = "Senha"
    case repeatPassword = "Repita a senha"
    case namePlaceholder = "Digite seu nome:"
    case emailPlaceholder = "Digite seu email:"
    case passwordPlaceholder = "Digite sua senha:"
    case repeatPasswordPlaceholder  = "Repita a senha:"
    case lottieAnimation = "registerLoad"
    case errorAlert = "Error"
    case registerAlert = "Registro!"
    case registerFieldsError = "Preencha todos os campos"
    case emailError = "Email invalido"
    case passwordError = "Senhas deve conter no minimo 6 caracteres"
    case repeatPasswordError = "Senhas não compativeis"
    case registerUser = "Usuário cadastrado."
}

class RegisterViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nameLebel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var lottieBackgroundView: UIView!
    
    // MARK: - Properties
    
    var viewModel: RegisterViewModel = RegisterViewModel()
    let lottieView: LottieAnimationView = LottieAnimationView(name: RegisterStrings.lottieAnimation.rawValue)
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupView()
        setupTextFieldDelegate()
        viewModel.setUpDelegate(delegate: self)
    }
    
    // MARK: - Setup
    
    private func setupTextFieldDelegate() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        nameLebel.text = RegisterStrings.nameLabel.rawValue
        emailLabel.text = RegisterStrings.emailLabel.rawValue
        passwordLabel.text = RegisterStrings.password.rawValue
        repeatPasswordLabel.text = RegisterStrings.repeatPassword.rawValue
        
        nameTextField.setupDefaultTextField(placeholder: RegisterStrings.namePlaceholder.rawValue)
        emailTextField.setupDefaultTextField(placeholder: RegisterStrings.emailPlaceholder.rawValue)
        passwordTextField.setupDefaultTextField(placeholder: RegisterStrings.passwordPlaceholder.rawValue)
        repeatPasswordTextField.setupDefaultTextField(placeholder: RegisterStrings.repeatPasswordPlaceholder.rawValue)
        
        nameTextField.autocapitalizationType = .words
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
        
        registerButton.backgroundColor = .buttonColor
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        
        lottieBackgroundView.backgroundColor = .lottieBack
        lottieView.contentMode = .scaleAspectFit
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieBackgroundView.isHidden = true
        
        backImageView.tintColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackButton))
        backImageView.addGestureRecognizer(tapGesture)
        backImageView.isUserInteractionEnabled = true
    }
    
    func setupLottieConstraints() {
        lottieBackgroundView.addSubview(lottieView)
        NSLayoutConstraint.activate([
            lottieView.widthAnchor.constraint(equalToConstant: 65),
            lottieView.heightAnchor.constraint(equalToConstant: 65),
            lottieView.centerXAnchor.constraint(equalTo: lottieBackgroundView.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: lottieBackgroundView.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
        if viewModel.isFormValid() && nameTextField.hasText && emailTextField.hasText && passwordTextField.hasText && repeatPasswordTextField.hasText {
            viewModel.registerUser()
        } else {
            Alert.showAlert(on: self, withTitle: RegisterStrings.errorAlert.rawValue, message: RegisterStrings.registerFieldsError.rawValue, actions: nil)
        }
    }
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func validateNameTextField(_ textField: UITextField) {
        guard let name = textField.text, !name.isEmpty else {
            return
        }
        
        if viewModel.isValidName(name: name) {
            textField.layer.borderWidth = 0
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
        }
    }

    private func validateEmailTextField(_ textField: UITextField) {
        guard let email = textField.text, !email.isEmpty else {
            return
        }
        
        if viewModel.isValidEmail(email: email) {
            textField.layer.borderWidth = 0
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            Alert.showAlert(on: self, withTitle: RegisterStrings.errorAlert.rawValue, message: RegisterStrings.emailError.rawValue, actions: nil)
        }
    }

    private func validatePasswordField(_ textField: UITextField) {
        guard let password = textField.text, !password.isEmpty else {
            return
        }
        
        if viewModel.isValidPassword(password: password) {
            textField.layer.borderWidth = 0
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            Alert.showAlert(on: self, withTitle: RegisterStrings.errorAlert.rawValue, message: RegisterStrings.passwordError.rawValue, actions: nil)
        }
    }

    private func validateRepeatedPasswordField(_ textField: UITextField) {
        guard let repeatPassword = textField.text, !repeatPassword.isEmpty else {
            return
        }
        
        if viewModel.isValidaRepeatPassword(repeatPassword: repeatPassword){
            textField.layer.borderWidth = 0
            passwordTextField.layer.borderWidth = 0
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 2
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            Alert.showAlert(on: self, withTitle: RegisterStrings.errorAlert.rawValue, message: RegisterStrings.repeatPasswordError.rawValue, actions: nil)
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            textField.layer.borderWidth = 0
            validateNameTextField(textField)
        case emailTextField:
            textField.layer.borderWidth = 0
            validateEmailTextField(textField)
        case passwordTextField:
            textField.layer.borderWidth = 0
            validatePasswordField(textField)
        case repeatPasswordTextField:
            textField.layer.borderWidth = 0
            validateRepeatedPasswordField(textField)
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = CGColor(red: 116/255, green: 59/255, blue: 157/255, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - RegisterViewModelDelegate

extension RegisterViewController: RegisterViewModelDelegate {
    func didCreateUserSuccess() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
        Alert.showAlert(on: self, withTitle: RegisterStrings.registerAlert.rawValue, message: RegisterStrings.registerUser.rawValue, actions: nil)
    }
    
    func didCreateUserFailure(error: String) {
        Alert.showAlert(on: self, withTitle: RegisterStrings.errorAlert.rawValue, message: error, actions: nil)
    }
    
    func setLottieView() {
        setupLottieConstraints()
        lottieView.loopMode = .loop
        lottieView.play()
        lottieBackgroundView.isHidden = false
    }
    
    func removeLottieView() {
        lottieView.stop()
        lottieBackgroundView.isHidden = true
    }

}
