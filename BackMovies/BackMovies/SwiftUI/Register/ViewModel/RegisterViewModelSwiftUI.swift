//
//  RegisterViewModelSwiftUI.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/06/24.
//

import Foundation
import FirebaseAuth

class RegisterViewModelSwiftUI: ObservableObject {
    
    @Published var name: String = "" {
        didSet {
            isValidName()
        }
    }
    @Published var email: String = "" {
        didSet {
            isValidEmail()
        }
    }
    @Published var password: String = "" {
        didSet {
            isValidPassword()
        }
    }
    @Published var repeatedPassword: String = "" {
        didSet {
            isValidRepeatPassword()
        }
    }
    
    @Published var nameValid: Bool = true
    @Published var emailValid: Bool = true
    @Published var passwordValid: Bool = true
    @Published var repeatedPasswordValid: Bool = true
    @Published var showAlert: Bool = false
    
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    func isFormValid() -> Bool {
        return isValidName() && isValidEmail() && isValidPassword() && isValidRepeatPassword()
    }
    
    func registerUser() {
        if isFormValid() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error == nil {
                    FirestoreManager.shared.createUser(name: self.name, email: self.email) { error in
                        if let error {
                            self.alertTitle = "Error"
                            self.alertMessage = error.localizedDescription
                            self.showAlert.toggle()
                        } else {
                            self.alertTitle = "Sucesso"
                            self.alertMessage = "Conta criada com sucesso"
                            self.showAlert.toggle()
                        }
                    }
                } else {
                    self.alertTitle = "Error"
                    self.alertMessage = error?.localizedDescription ?? ""
                    self.showAlert.toggle()
                }
            }
        } else {
            self.alertTitle = "Error"
            self.alertMessage = "Preencha todos os campos corretemante"
            self.showAlert.toggle()
        }
    }
    
    @discardableResult
    func isValidName() -> Bool {
        let nameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        nameValid = NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
        return nameValid
    }
    
    @discardableResult
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        emailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        return emailValid
    }
    
    @discardableResult
    func isValidPassword() -> Bool {
        let passwordRegex = ".{6,}"
        passwordValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        return passwordValid
    }
    
    @discardableResult
    func isValidRepeatPassword() -> Bool {
        repeatedPasswordValid = repeatedPassword == password
        return repeatedPasswordValid
    }
}
