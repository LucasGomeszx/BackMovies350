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
    case registerView = "RegisterView"
    case registerViewController = "RegisterViewController"
    case recoverView = "RecoverView"
    case recoverViewController = "RecoverViewController"
    case tabBarView = "TabBarView"
    case tabBarViewController = "TabBarViewController"
    case alertError = "Error"
    case alertEmailPasswordError = "Email ou senha invalidos."
    case alertEmailError = "Email invalido"
    case alertPasswordError = "Senhas deve conter no minimo 6 caracteres"
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
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
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
        let vc: RegisterViewController? = UIStoryboard(name: LoginStrings.registerView.rawValue, bundle: nil).instantiateViewController(withIdentifier: LoginStrings.registerViewController.rawValue) as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @objc func tappedRecoverButton() {
        let vc: RecoverViewController? = UIStoryboard(name: LoginStrings.recoverView.rawValue, bundle: nil).instantiateViewController(withIdentifier: LoginStrings.recoverViewController.rawValue) as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    private func naviHomeScreen() {
        let vc: TabBarViewController? = UIStoryboard(name: LoginStrings.tabBarView.rawValue, bundle: nil).instantiateViewController(withIdentifier: LoginStrings.tabBarViewController.rawValue) as? TabBarViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    //MARK: - Validacoes.
    
    @IBAction func tappedLoginButton(_ sender: Any) {
        if viewModel.isFormValid() && emailTextField.hasText && passwordTextField.hasText {
            viewModel.loginBackMovies()
        }else {
            Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: LoginStrings.alertEmailPasswordError.rawValue, actions: nil)
        }
    }
    
    @IBAction func tappedGoogleButton(_ sender: Any) {
        viewModel.loginGoogle(vc: self)
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
            Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: LoginStrings.alertEmailError.rawValue, actions: nil)
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
            Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: LoginStrings.alertPasswordError.rawValue, actions: nil)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = CGColor(red: 116/255, green: 59/255, blue: 157/255, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

//MARK: - LoginViewModelDelegate

extension LoginViewController: LoginViewModelDelegate {
    func didsignInSucess() {
        naviHomeScreen()
    }
    
    func didsignInFailure(error: String) {
        Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: error, actions: nil)
    }
    
    func didSignInGoogleSucess() {
        naviHomeScreen()
    }
    
    func didSignInGoogleFailure(error: String) {
        Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: error, actions: nil)
    }
    
}
