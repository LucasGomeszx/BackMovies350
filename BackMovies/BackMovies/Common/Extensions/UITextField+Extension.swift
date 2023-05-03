//
//  place.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 03/05/23.
//

import Foundation
import UIKit

extension UITextField {
    
    func setupDefaultTextField(placeholder: String) {
        let atributoCor = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: atributoCor)
        self.backgroundColor = .backGray
        self.textColor = .white
    }
    
}
