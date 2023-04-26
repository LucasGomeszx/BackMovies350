//
//  LoginViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

class LoginViewModel {
    
    private var email: String?
    private var password: String?
    
    func isFormValid() -> Bool {
        guard let email = email,
              let password = password else {return false}
        if isValidEmail(email: email) && isValidPassword(password: password) {
            return true
        }else {
            return false
        }
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
    
}
