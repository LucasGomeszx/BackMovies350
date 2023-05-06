//
//  ViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/03/23.
//

import UIKit

enum LoginStrings: String {
    case emailPlaceholder = "Digite seu email:"
    case passwordPlaceholder = "Digite sua senha:"
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginApple: UIButton!
    @IBOutlet weak var loginGoolge: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var recoverLabel: UILabel!
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupTextFieldDelegate()
        viewModel.setupDelegate(delegate: self)
    }
    
    func setUpView() {
        emailTextField.setupDefaultTextField(placeholder: LoginStrings.emailPlaceholder.rawValue)
        emailTextField.keyboardType = .emailAddress
        passwordTextField.setupDefaultTextField(placeholder: LoginStrings.passwordPlaceholder.rawValue)
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 20
        registerButton.layer.cornerRadius = 20
        loginApple.layer.cornerRadius = 20
        loginGoolge.layer.cornerRadius = 20
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedRecoverButton))
        recoverLabel.addGestureRecognizer(tapGesture)
        recoverLabel.isUserInteractionEnabled = true
    }
    
    func setupTextFieldDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: - Navegacoes.
    
    @IBAction func tappedLoginButton(_ sender: Any) {
        if viewModel.isFormValid() && emailTextField.hasText && passwordTextField.hasText {
            viewModel.loginBackMovies()
        }else {
            Alert.showAlert(on: self, withTitle: "Registro", message: "Email ou senha invalidos.", actions: nil)
        }
    }
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
        let vc: RegisterViewController? = UIStoryboard(name: "RegisterView", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @objc func tappedRecoverButton() {
        let vc: RecoverViewController? = UIStoryboard(name: "RecoverView", bundle: nil).instantiateViewController(withIdentifier: "RecoverViewController") as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    //MARK: - Validacoes.
    
    private func validateEmailTextField(_ textField: UITextField) {
        guard let email = textField.text, !email.isEmpty else {
            return
        }
        
        if viewModel.isValidEmail(email: email) {
            textField.layer.borderWidth = 0
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            Alert.showAlert(on: self, withTitle: "Error", message: "Email invalido", actions: nil)
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
            Alert.showAlert(on: self, withTitle: "Error", message: "Senhas deve conter no minimo 6 caracteres", actions: nil)
        }
    }
    
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            textField.layer.borderWidth = 0
            validateEmailTextField(textField)
        case passwordTextField:
            textField.layer.borderWidth = 0
            validatePasswordField(textField)
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    func didsignInSucess() {
        let vc: TabBarViewController? = UIStoryboard(name: "TabBarView", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func didsignInFailure(error: String) {
        Alert.showAlert(on: self, withTitle: "Error", message: error, actions: nil)
    }
}
