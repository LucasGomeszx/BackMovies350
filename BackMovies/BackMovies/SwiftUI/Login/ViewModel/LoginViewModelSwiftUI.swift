//
//  LoginViewModelSwiftUI.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 03/06/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewModelSwiftUI: ObservableObject {
    
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var goToRegisterView: Bool = false
    @Published var goToRecoveryView: Bool = false
    @Published var goToTabBarView: Bool = false
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertError: String = ""
    
    func goToResgisterView() {
        goToRegisterView.toggle()
    }
    
    func goToRecovery() {
        goToRecoveryView.toggle()
    }
    
    func goToTabBar() {
        goToTabBarView.toggle()
    }
    
    func loginBackMovies() {
        isLoading = true
        Auth.auth().signIn(withEmail: emailTextField, password: passwordTextField) { authResult, error in
            if error != nil {
                self.alertError = error?.localizedDescription ?? ""
                self.showAlert = true
                self.isLoading = false
            }else {
                self.isLoading = false
                self.goToTabBar()
            }
        }
    }
}
