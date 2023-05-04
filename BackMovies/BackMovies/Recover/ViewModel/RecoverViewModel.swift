//
//  RecoverViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation

class RecoverViewModel {
    
    var email: String?
    
    func isFormValid() -> Bool {
        guard let email = email else {return false}
        if isValidEmail(email: email) {
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
    
}
