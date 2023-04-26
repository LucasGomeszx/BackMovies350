//
//  RegisterViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 25/04/23.
//

import Foundation

class RegisterViewModel {
    
    var name: String?
    var email: String?
    var cpf: String?
    var password: String?
    var repeatedPassword: String?
    
    func isFormValid() -> Bool {
        guard let name = name, isValidName(name: name),
              let email = email, isValidEmail(email: email),
              let cpf = cpf, isValidCPF(cpf: cpf),
              let password = password, isValidPassword(password: password),
              let repeatedPassword = repeatedPassword, password == repeatedPassword else {
            return false
        }
        return true
    }
    
    func isValidName(name: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }
    
    func isValidCPF(cpf: String) -> Bool {
        return true
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = ".{6,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    
}
