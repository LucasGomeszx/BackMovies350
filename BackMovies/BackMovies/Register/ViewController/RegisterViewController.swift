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
    
    private func validateNameTextField(_ textField: UITextField) {
        guard let name = textField.text, !name.isEmpty else {
            return
        }
        
        if viewModel.isValidName(name: name) {
            textField.layer.borderWidth = 0
            viewModel.name = name
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
            viewModel.email = email
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            Alert.showAlert(on: self, withTitle: "Error", message: "Email invalido", actions: nil)
        }
    }

    private func validateCPFField(_ textField: UITextField) {
        guard let cpf = textField.text, !cpf.isEmpty else {
            return
        }
        
        if viewModel.isValidCPF(cpf: cpf) {
            textField.layer.borderWidth = 0
            viewModel.cpf = cpf
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
        }
    }

    private func validatePasswordField(_ textField: UITextField) {
        guard let password = textField.text, !password.isEmpty else {
            return
        }
        
        if viewModel.isValidPassword(password: password) {
            textField.layer.borderWidth = 0
            viewModel.password = password
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            Alert.showAlert(on: self, withTitle: "Error", message: "Senhas deve conter no minimo 6 caracteres", actions: nil)
        }
    }

    private func validateRepeatedPasswordField(_ textField: UITextField) {
        guard let repeatPassword = textField.text, !repeatPassword.isEmpty else {
            return
        }
        
        if repeatPassword == viewModel.password {
            textField.layer.borderWidth = 0
            passwordTextField.layer.borderWidth = 0
            viewModel.repeatedPassword = repeatPassword
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 2
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            Alert.showAlert(on: self, withTitle: "Error", message: "Senhas diferentes", actions: nil)
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            validateNameTextField(textField)
        case emailTextField:
            validateEmailTextField(textField)
        case cpfTextField:
            validateCPFField(textField)
        case passwordTextField:
            validatePasswordField(textField)
        case repeatPasswordTextField:
            validateRepeatedPasswordField(textField)
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
