//
//  RecoverViewController.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 09/03/23.
//

import UIKit

enum RecoverStrings: String {
    case emailPlaceholder = "Digite seu email:"
}

class RecoverViewController: UIViewController {
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var loginProblemLabel: UILabel!
    @IBOutlet weak var recoverLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var recoverButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupView()
        setUpTextFieldDelegate()
    }
    
    var viewModel: RecoverViewModel = RecoverViewModel()
    
    private func setUpTextFieldDelegate() {
        emailTextField.delegate = self
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        backImageView.tintColor = .white
        emailTextField.setupDefaultTextField(placeholder: RecoverStrings.emailPlaceholder.rawValue)
        emailTextField.keyboardType = .emailAddress
        recoverButton.layer.cornerRadius = 20
        recoverButton.clipsToBounds = true
    }
    
    
    @IBAction func tappedBackButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tappedRecoverButton(_ sender: Any) {
        if viewModel.isFormValid() && emailTextField.hasText {
            Alert.showAlert(on: self, withTitle: "Registro", message: "Senha alterada!!", actions: nil)
        }else {
            Alert.showAlert(on: self, withTitle: "Registro", message: "Preencha todos os campos corretamente", actions: nil)
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
            Alert.showAlert(on: self, withTitle: "Error", message: "Email invalido", actions: nil)
        }
    }
    
}

extension RecoverViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            validateEmailTextField(textField)
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
