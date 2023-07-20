//
//  UIImage+Extension.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 19/07/23.
//

import UIKit

extension UIImage {
    func resizeImage(image: UIImage,targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / (size.width)
        let heightRatio = targetSize.height / (size.height)

        // Mantém a proporção da imagem original
        let scaleFactor = min(widthRatio, heightRatio)

        let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let renderer = UIGraphicsImageRenderer(size: scaledSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledSize))
        }
        
        return scaledImage
    }
    
}
