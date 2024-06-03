//
//  ViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/03/23.
//

import UIKit
import Firebase
import GoogleSignIn
import Lottie

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
    case lottieAnimation = "registerLoad"
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginGoolge: UIButton!
    @IBOutlet weak var loginApple: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var recoverLabel: UILabel!
    @IBOutlet weak var lottieBackView: UIView!
    
    let lottieView: LottieAnimationView = LottieAnimationView(name: LoginStrings.lottieAnimation.rawValue)
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureNavigation()
        setupTextFieldDelegate()
        viewModel.setupDelegate(delegate: self)
        viewModel.userAutentication()
    }
    
    func setUpView() {
        lottieBackView.isHidden = true
        lottieBackView.backgroundColor = .lottieBack
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.setupDefaultTextField(placeholder: LoginStrings.emailPlaceholder.rawValue)
        emailTextField.keyboardType = .emailAddress
        passwordTextField.setupDefaultTextField(placeholder: LoginStrings.passwordPlaceholder.rawValue)
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 20
        registerButton.layer.cornerRadius = 20
        loginGoolge.layer.cornerRadius = 20
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedRecoverButton))
        loginApple.layer.cornerRadius = 20
        recoverLabel.textColor = .white
        recoverLabel.addGestureRecognizer(tapGesture)
        recoverLabel.isUserInteractionEnabled = true
        let image = resizeImage(image: UIImage(named: "apple") ?? UIImage(), targetSize: CGSize(width: 20, height: 20))
        loginApple.setImage(image, for: .normal)

    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Mantém a proporção da imagem original
        let scaleFactor = min(widthRatio, heightRatio)

        let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let renderer = UIGraphicsImageRenderer(size: scaledSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledSize))
        }
        
        return scaledImage
    }
    
    func setupTextFieldDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func startLottieAnimation() {
        lottieBackView.addSubview(lottieView)
        NSLayoutConstraint.activate([
            lottieView.widthAnchor.constraint(equalToConstant: 65),
            lottieView.heightAnchor.constraint(equalToConstant: 65),
            lottieView.centerXAnchor.constraint(equalTo: lottieBackView.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: lottieBackView.centerYAnchor)
        ])
        lottieView.loopMode = .loop
        lottieView.play()
        lottieBackView.isHidden = false
    }
    
    private func stopLottieAnimation() {
        lottieView.stop()
        lottieView.removeFromSuperview()
        lottieBackView.isHidden = true
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
        if emailTextField.hasText && passwordTextField.hasText {
            guard let email = emailTextField.text else {return}
            guard let password = passwordTextField.text else {return}
            if viewModel.isValidEmail(email: email) && viewModel.isValidPassword(password: password) {
                emailTextField.text = ""
                passwordTextField.text = ""
                viewModel.loginBackMovies()
            }else {
                Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: LoginStrings.alertEmailPasswordError.rawValue, actions: nil)
            }
        } else {
            Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: LoginStrings.alertEmailPasswordError.rawValue, actions: nil)
        }
    }
    
    @IBAction func tappedGoogleButton(_ sender: Any) {
            self.startLottieAnimation()
            
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            // Start the sign in flow!
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
                guard error == nil else {
                    self.stopLottieAnimation()
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString
                else {
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        self.stopLottieAnimation()
                        Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: error.localizedDescription, actions: nil)
                        return
                    }
                    
                    guard let user = result?.user,
                          let email = user.email else {
                        self.stopLottieAnimation()
                        // Tratar o caso em que o email não está disponível
                        return
                    }
                    FirestoreManager.shared.createUser(email: email) { error in
                        if let error = error {
                            Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: error.localizedDescription, actions: nil)
                        }else {
                            self.stopLottieAnimation()
                            self.naviHomeScreen()
                        }
                    }
                }
            }
        }
    
    @IBAction func tappedLoginApple(_ sender: Any) {
        print("AAAAAAA")
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
    func didSignInSuccess() {
        naviHomeScreen()
    }
    
    func didSignInFailure(error: String) {
        Alert.showAlert(on: self, withTitle: LoginStrings.alertError.rawValue, message: error, actions: nil)
    }
    
    func startLottieView() {
        startLottieAnimation()
    }
    
    func stopLottieView() {
        stopLottieAnimation()
    }
}
