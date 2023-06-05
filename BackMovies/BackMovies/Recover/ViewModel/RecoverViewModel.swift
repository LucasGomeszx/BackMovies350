//
//  RecoverViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 26/04/23.
//

import Foundation
import Firebase

protocol RecoverViewModelDelegate: AnyObject {
    func didSendEmailSucess()
    func didSendEmailFailure(error: String)
    func startLottieView()
    func stopLottieView()
}

class RecoverViewModel {
    
    private var email: String?
    private var auth: Auth = Auth.auth()
    private var delegate: RecoverViewModelDelegate?
    
    func setupDelegate(delegate: RecoverViewModelDelegate) {
        self.delegate = delegate
    }
    
    func sendPasswordReset() {
        delegate?.startLottieView()
        guard let email = email else {return}
        auth.sendPasswordReset(withEmail: email) { error in
          if error != nil {
              self.delegate?.stopLottieView()
              self.delegate?.didSendEmailFailure(error: error?.localizedDescription ?? "")
          } else {
              self.delegate?.stopLottieView()
              self.delegate?.didSendEmailSucess()
          }
        }
    }
    
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
