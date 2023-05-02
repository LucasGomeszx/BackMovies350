//
//  RegisterViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 25/04/23.
//

protocol RegisterViewModelDelegate: AnyObject {
    func didCreateUserSuccess()
    func didCreateUserFailure()
}

import Foundation
import Firebase

class RegisterViewModel {
    
    private var name: String?
    private var email: String?
    private var password: String?
    private var repeatedPassword: String?
    private weak var delegate: RegisterViewModelDelegate?
    
    func isFormValid() -> Bool {
        guard let name = name,
              let email = email,
              let password = password,
              let repeatedPassword = repeatedPassword else {return false}
        if isValidName(name: name) && isValidEmail(email: email) && isValidPassword(password: password) && repeatedPassword == password {
            return true
        }else {
            return false
        }
    }
    
    public func registerUser() {
        guard let email = email else {return}
        guard let password = password else {return}
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                self.delegate?.didCreateUserSuccess()
            }else {
                self.delegate?.didCreateUserFailure()
            }
        }
    }
    
    func isValidName(name: String) -> Bool {
        self.name = name
        let nameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }
    
    func isValidEmail(email: String) -> Bool {
        self.email = email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        self.password = password
        let passwordRegex = ".{6,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func isValidaRepeatPassword(repeatPassword: String) -> Bool {
        self.repeatedPassword = repeatPassword
        return repeatPassword == password
    }
    
}
