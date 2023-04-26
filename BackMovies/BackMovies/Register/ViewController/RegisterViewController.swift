//
//  RegisterViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 09/03/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var viewModel: RegisterViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupView()
        setUpTextFieldDelegate()
        registerButton.isEnabled = false
    }
    
    private func setUpTextFieldDelegate() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        cpfTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        backButton.tintColor = .white
        emailTextField.keyboardType = .emailAddress
        cpfTextField.keyboardType = .numberPad
        passwordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
    }
    
    
    @IBAction func tappedBackButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
        Alert.showAlert(on: self, withTitle: "Registro", message: "Usuario cadastrado!!", actions: nil)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            if let name = textField.text, !name.isEmpty {
                if !viewModel.isValidName(name: name) {
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = UIColor.red.cgColor
                } else {
                    textField.layer.borderWidth = 0
                    viewModel.name = name
                }
            }
        case emailTextField:
            if let email = textField.text, !email.isEmpty {
                if !viewModel.isValidEmail(email: email) {
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = UIColor.red.cgColor
                    Alert.showAlert(on: self, withTitle: "Error", message: "Email invalido", actions: nil)
                } else {
                    textField.layer.borderWidth = 0
                    viewModel.email = email
                }
            }
        case cpfTextField:
            if let cpf = textField.text, !cpf.isEmpty {
                if !viewModel.isValidCPF(cpf: cpf) {
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = UIColor.red.cgColor
                } else {
                    textField.layer.borderWidth = 0
                    viewModel.cpf = cpf
                }
            }
        case passwordTextField:
            if let password = textField.text, !password.isEmpty {
                if !viewModel.isValidPassword(password: password) {
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = UIColor.red.cgColor
                    Alert.showAlert(on: self, withTitle: "Error", message: "Senhas deve conter no minimo 6 caracteres", actions: nil)
                } else {
                    textField.layer.borderWidth = 0
                    viewModel.password = password
                }
            }
        case repeatPasswordTextField:
            if let repeatPassword = textField.text, !repeatPassword.isEmpty {
                if repeatPassword != viewModel.password {
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = UIColor.red.cgColor
                    passwordTextField.layer.borderWidth = 2
                    passwordTextField.layer.borderColor = UIColor.red.cgColor
                    Alert.showAlert(on: self, withTitle: "Error", message: "Senhas diferentes", actions: nil)
                } else {
                    textField.layer.borderWidth = 0
                    passwordTextField.layer.borderWidth = 0
                    viewModel.repeatedPassword = repeatPassword
                }
            }
        default:
            break
        }
        
        registerButton.isEnabled = viewModel.isFormValid()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
