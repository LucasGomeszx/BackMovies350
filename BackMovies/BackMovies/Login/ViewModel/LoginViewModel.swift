//
//  LoginViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Firebase
import GoogleSignIn
import UIKit

protocol LoginViewModelDelegate: AnyObject {
    func didsignInSucess()
    func didsignInFailure(error: String)
    func didSignInGoogleSucess()
    func didSignInGoogleFailure(error: String)
}

class LoginViewModel {
    
    private var email: String?
    private var password: String?
    private var delegate: LoginViewModelDelegate?
    
    func setupDelegate(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loginGoogle(vc: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { result, error in
          guard error == nil else {
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
                if error != nil {
                    self.delegate?.didSignInGoogleFailure(error: error?.localizedDescription ?? "")
                }else {
                    self.delegate?.didSignInGoogleSucess()
                }
            }
        }
    }
    
    func loginBackMovies() {
        guard let email = email,
              let password = password else {return}
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.delegate?.didsignInFailure(error: error?.localizedDescription ?? "")
            }else {
                self.delegate?.didsignInSucess()
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
    
}
