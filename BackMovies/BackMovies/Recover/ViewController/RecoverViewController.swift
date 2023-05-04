//
//  RecoverViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 09/03/23.
//

import UIKit

enum RecoverStrings: String {
    case loginProblemLabel = "Problemas para entrar?"
    case recoverLabel = "Insira seu email e enviaremos um link para redefinir sua senha."
    case emailPlaceholder = "Digite seu email:"
    case registerAlert = "Registro"
    case errorAlert = "Erro"
    case sendEmailAlert = "Link enviado"
    case invalidInputAlert = "Preencha todos os campos corretamente"
    case invalidEmailAlert = "Email inválido"
}

class RecoverViewController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var loginProblemLabel: UILabel!
    @IBOutlet weak var recoverLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var recoverButton: UIButton!
    
    // MARK: - Properties
    
    private var viewModel: RecoverViewModel = RecoverViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupView()
        setUpTextFieldDelegate()
        viewModel.setupDelegate(delegate: self)
    }
    
    // MARK: - Private methods
    
    private func setUpTextFieldDelegate() {
        emailTextField.delegate = self
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        loginProblemLabel.text = RecoverStrings.loginProblemLabel.rawValue
        recoverLabel.text = RecoverStrings.recoverLabel.rawValue
        backImageView.tintColor = .white
        emailTextField.setupDefaultTextField(placeholder: RecoverStrings.emailPlaceholder.rawValue)
        emailTextField.keyboardType = .emailAddress
        recoverButton.layer.cornerRadius = 20
        recoverButton.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackImageViewTap))
        backImageView.addGestureRecognizer(tapGesture)
        backImageView.isUserInteractionEnabled = true
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
            Alert.showAlert(on: self, withTitle: RecoverStrings.errorAlert.rawValue, message: RecoverStrings.invalidEmailAlert.rawValue, actions: nil)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func handleRecoverButtonTap(_ sender: Any) {
        if viewModel.isFormValid() && emailTextField.hasText {
            viewModel.sendPasswordReset()
        } else {
            Alert.showAlert(on: self, withTitle: RecoverStrings.registerAlert.rawValue, message: RecoverStrings.invalidInputAlert.rawValue, actions: nil)
        }
    }
    
    @objc private func handleBackImageViewTap() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - UITextFieldDelegate

extension RecoverViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            textField.layer.borderWidth = 0
            validateEmailTextField(textField)
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

// MARK: - RecoverViewModelDelegate

extension RecoverViewController: RecoverViewModelDelegate {
    func didSendEmailSucess() {
        Alert.showAlert(on: self, withTitle: RecoverStrings.registerAlert.rawValue, message: RecoverStrings.sendEmailAlert.rawValue, actions: nil)
    }
    
    func didSendEmailFailure(error: String) {
        Alert.showAlert(on: self, withTitle: RegisterStrings.errorAlert.rawValue, message: error, actions: nil)
    }
    
}
