//
//  RegisterView.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/06/24.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: RegisterViewModelSwiftUI = RegisterViewModelSwiftUI()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.cinemaBack)
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 15) {
                    
                    HStack(alignment: .center) {
                        
                        Button {
                            dismiss()
                        }label: {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 25, height: 25)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Text("Cadastro")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .offset(x: -26)
                        
                        Spacer()
                        
                    }
                    
                    BackMoviesTextField(textFieldText: $viewModel.name, placeholder: "Nome", label: "Nome")
 
                    BackMoviesTextField(textFieldText: $viewModel.name, placeholder: "E-mail", label: "E-mail")
                    
                    BackMoviesSecureField(textFieldText: $viewModel.password, placeholder: "Senha:", label: "Senha")

                    BackMoviesSecureField(textFieldText: $viewModel.repeatPassword, placeholder: "Repita senha:", label: "Repita senha")
                    
                    Button {
                        
                    } label: {
                        Text("Cadastrar")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: geo.size.width / 1.45, height: 50)
                            .background(Color.buttonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .padding(.top, 100)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    RegisterView()
}
