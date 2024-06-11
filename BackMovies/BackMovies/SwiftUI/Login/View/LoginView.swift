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
                        
                        BackMoviesTextField(textFieldText: $viewModel.emailTextField,
                                            borderColor: Color.clear,
                                            placeholder: "E-mail",
                                            label: "E-mail")
                        
                        BackMoviesSecureField(textFieldText: $viewModel.passwordTextField,
                                              borderColor: Color.clear,
                                              placeholder: "Senha",
                                              label: "Senha")
                        
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
                    .frame(width: geo.size.width - 26, height: geo.size.height)
                    
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
                    RegisterView()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $viewModel.goToRecoveryView) {
                    RecoverStoryboard()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $viewModel.goToTabBarView) {
                    TabBarView()
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

#Preview {
    LoginView()
}
