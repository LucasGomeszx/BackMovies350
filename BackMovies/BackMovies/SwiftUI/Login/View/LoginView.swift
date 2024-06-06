//
//  LoginView.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 03/06/24.
//

import SwiftUI
import UIKit

struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModelSwiftUI = LoginViewModelSwiftUI()
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Image(.cinemaBack)
                        .resizable()
                        .scaledToFill()
                    
                    VStack {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width / 1.5)
                            .padding(.top, 100)
                        
                        Text("E-mail")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: geo.size.width - 26, alignment: .leading)
                            .padding(.horizontal)
                        
                        
                        ZStack(alignment: .leading) {
                            if viewModel.emailTextField.isEmpty {
                                Text("E-mail:")
                                    .foregroundStyle(.gray.opacity(0.5))
                                    .padding(.horizontal)
                            }
                            TextField("", text: $viewModel.emailTextField)
                                .padding(.horizontal)
                            
                        }
                        .frame(width: geo.size.width - 26, height:50 , alignment: .leading)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 20))
                        .background(Color.backGray)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        .padding(.bottom, 10)
                        
                        Text("Senha")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: geo.size.width - 26, alignment: .leading)
                            .padding(.horizontal)
                        
                        
                        ZStack(alignment: .leading) {
                            if viewModel.passwordTextField.isEmpty {
                                Text("Senha:")
                                    .foregroundStyle(.gray.opacity(0.5))
                                    .padding(.horizontal)
                            }
                            SecureField("", text: $viewModel.passwordTextField)
                                .padding(.horizontal)
                            
                        }
                        .frame(width: geo.size.width - 26, height:50 , alignment: .leading)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 20))
                        .background(Color.backGray)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        
                        Button {
                            viewModel.loginBackMovies()
                        } label: {
                            Text("Logar")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                                .frame(width: geo.size.width / 1.45, height: 50)
                                .background(Color.buttonColor)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .padding(.top, 40)
                        
                        
                        Button {
                            viewModel.goToResgisterView()
                        } label: {
                            Text("Registrar")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                                .frame(width: geo.size.width / 1.45, height: 50)
                                .background(Color.buttonColor)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        Button {
                            viewModel.goToRecovery()
                        } label: {
                            Text("Esqueceu a senha?")
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .frame(width: geo.size.width / 2.5, height: 30)
                                .background(Color.black.opacity(0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Label("Logar com Google", image: "googleIcon")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                                .frame(width: geo.size.width / 1.45, height: 50)
                                .background(Color.buttonColor)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .padding(.bottom, 40)
                        
                        Spacer()
                        
                    }
                    
                    if viewModel.isLoading {
                        ZStack {
                            LottieView(name: "registerLoad", loopMode: .loop)
                                .scaleEffect(0.2)
                                .offset(y: -50)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(Color.lottieBack)
                    }
                    
                }
                .ignoresSafeArea()
                .frame(width: geo.size.width, height: geo.size.height)
                .navigationDestination(isPresented: $viewModel.goToRegisterView) {
                    RegisterStoryboard()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $viewModel.goToRecoveryView) {
                    RecoverStoryboard()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $viewModel.goToTabBarView) {
                    TabBarStoryboard()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
                .alert("Error", isPresented: $viewModel.showAlert) {
                    
                } message: {
                    Text(viewModel.alertError)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct RegisterStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Aqui você carrega o ViewController do Storyboard
        let storyboard = UIStoryboard(name: "RegisterView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "RegisterViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Atualizar o UIViewController, se necessário
    }
}

struct RecoverStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Aqui você carrega o ViewController do Storyboard
        let storyboard = UIStoryboard(name: "RecoverView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "RecoverViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Atualizar o UIViewController, se necessário
    }
}

struct TabBarStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Aqui você carrega o ViewController do Storyboard
        let storyboard = UIStoryboard(name: "TabBarView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "TabBarViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Atualizar o UIViewController, se necessário
    }
}

#Preview {
    LoginView()
}
