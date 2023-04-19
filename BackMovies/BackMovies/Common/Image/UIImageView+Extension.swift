//
//  UIImageView+Extension.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 17/04/23.
//

import Foundation

import UIKit

extension UIImageView {
    /**
     loadImageFromURL é um método para carregar uma imagem de uma URL com cache e um placeholder opcional.
     - Parameters:
        - url: A URL da imagem a ser carregada.
        - placeholder: A imagem a ser exibida enquanto a imagem está sendo carregada. Padrão é nil.
        - errorImage: A imagem a ser exibida se ocorrer um erro ao carregar a imagem. Padrão é nil.
        - completionHandler: O bloco de conclusão a ser executado quando a imagem for carregada com sucesso ou se ocorrer um erro.
     */
    func loadImageFromURL(_ url: URL, placeholder: UIImage? = nil, errorImage: UIImage? = nil, completionHandler: ((Result<UIImage, Error>) -> Void)? = nil) {
        
        self.image = placeholder
        
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            self.image = cachedImage
            completionHandler?(.success(cachedImage))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let data = data, let image = UIImage(data: data) else {
                    self.image = errorImage
                    completionHandler?(.failure(error ?? ImageLoadingError.unknownError))
                    return
                }
                ImageCache.shared.setImage(image: image, forKey: url.absoluteString)
                self.image = image
                completionHandler?(.success(image))
            }
        }.resume()
    }
}

// Enum que representa os possíveis erros que podem ocorrer ao carregar uma imagem
enum ImageLoadingError: Error {
    case unknownError
}
