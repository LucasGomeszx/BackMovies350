//
//  LoginViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import UIKit
import Firebase

protocol LoginViewModelDelegate: AnyObject {
    func didSignInSuccess()
    func didSignInFailure(error: String)
    func startLottieView()
    func stopLottieView()
}

class LoginViewModel {
    
    private var email: String?
    private var password: String?
    private var delegate: LoginViewModelDelegate?
    
    func setupDelegate(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loginBackMovies() {
        delegate?.startLottieView()
        guard let email = email,
              let password = password else {return}
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.delegate?.stopLottieView()
                self.delegate?.didSignInFailure(error: error?.localizedDescription ?? "")
            }else {
                self.delegate?.stopLottieView()
                self.delegate?.didSignInSuccess()
            }
        }
    }
    
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
    func userAutentication() {
        if Auth.auth().currentUser != nil {
            self.delegate?.didSignInSuccess()
        }
    }
}
