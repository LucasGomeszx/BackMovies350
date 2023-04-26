//
//  RecoverViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

class RecoverViewModel {
    
    var email: String?
    var cpf: String?
    var password: String?
    var repeatedPassword: String?
    
    func isFormValid() -> Bool {
        guard let email = email,
              let cpf = cpf,
              let password = password,
              let repeatedPassword = repeatedPassword else {return false}
        if isValidCPF(cpf: cpf) && isValidEmail(email: email) && isValidPassword(password: password) && isValidRepeatPassword(repeatPassword: repeatedPassword){
            return true
        }else {
            return false
        }
    }
    
    func isValidCPF(cpf: String) -> Bool {
        self.cpf = cpf
        return true
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
    
    func isValidRepeatPassword(repeatPassword: String) -> Bool {
        self.repeatedPassword = repeatPassword
        if repeatPassword == password {
            return true
        }else {
            return false
        }
    }
    
}
