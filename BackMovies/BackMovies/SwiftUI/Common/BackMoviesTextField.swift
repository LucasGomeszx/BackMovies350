//
//  BackMoviesTextField.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 07/06/24.
//

import SwiftUI

struct BackMoviesTextField: View {
    
    @Binding var textFieldText: String
    var borderColor: Color
    var placeholder: String
    var label: String

    var body: some View {
        VStack(alignment:.leading) {
            Text(label)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            ZStack(alignment: .leading) {
                if textFieldText.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal)
                }
                TextField("", text: $textFieldText)
                    .padding(.horizontal)
            }
            .frame(height: 50, alignment: .leading)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .font(.system(size: 20))
            .background(Color.backGray)
            .foregroundColor(.white)
            .border(borderColor, width: 2)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    @State var name = ""
    
    return BackMoviesTextField(textFieldText: $name, borderColor: Color.white, placeholder: "", label: "Text")
}
