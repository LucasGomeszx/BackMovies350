//
//  UIImageView+Extension.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 17/04/23.
//

import Foundation
import UIKit
import Lottie

extension UIImageView {

    func loadImageFromURL(_ url: URL,
                          completionHandler: ((Result<UIImage, Error>) -> Void)? = nil) {
        
        let animationView = LottieAnimationView(name: "imageLoad")
        animationView.frame = bounds
        animationView.contentMode = .scaleAspectFit
        addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 75),
            animationView.widthAnchor.constraint(equalToConstant: 75),
        ])
        animationView.loopMode = .loop
        animationView.play()
        
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            animationView.stop()
            animationView.removeFromSuperview()
            image = cachedImage
            completionHandler?(.success(cachedImage))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                animationView.stop()
                animationView.removeFromSuperview()
                guard error == nil,
                      let data = data,
                      let image = UIImage(data: data) else {
                    self.image = UIImage(named: "emptyImage")
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
