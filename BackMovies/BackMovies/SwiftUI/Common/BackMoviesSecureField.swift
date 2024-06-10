//
//  BackMoviesSecureField.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 10/06/24.
//

import SwiftUI

struct BackMoviesSecureField: View {
    
    @Binding var textFieldText: String
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
                SecureField("", text: $textFieldText)
                    .padding(.horizontal)
            }
            .frame(height: 50, alignment: .leading)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .font(.system(size: 20))
            .background(Color.backGray)  // Color.backGray is changed to Color.gray for simplicity
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    @State var name = ""
    
    return BackMoviesSecureField(textFieldText: $name, placeholder: "Text", label: "Text")
}
