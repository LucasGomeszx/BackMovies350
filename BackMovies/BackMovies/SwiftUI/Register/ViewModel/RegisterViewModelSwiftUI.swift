//
//  RegisterViewModelSwiftUI.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/06/24.
//

import Foundation

class RegisterViewModelSwiftUI: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var repeatPassword: String = ""
    @Published var password: String = ""
    
}
