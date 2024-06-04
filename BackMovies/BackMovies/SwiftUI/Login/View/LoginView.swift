//
//  LoginView.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 03/06/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    
    var body: some View {
        GeometryReader { geo in
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
                        if emailText.isEmpty {
                            Text("E-mail:")
                                .foregroundStyle(.gray.opacity(0.5))
                                .padding(.horizontal)
                        }
                        TextField("", text: $emailText)
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
                        if passwordText.isEmpty {
                            Text("Senha:")
                                .foregroundStyle(.gray.opacity(0.5))
                                .padding(.horizontal)
                        }
                        SecureField("", text: $passwordText)
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
                        
                    } label: {
                        Text("Registrar")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: geo.size.width / 1.45, height: 50)
                            .background(Color.buttonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    Button {
                        
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
            }
            .ignoresSafeArea()
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    LoginView()
}
