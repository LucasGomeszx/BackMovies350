//
//  ImageCache.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 17/04/23.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private let cacheQueue = DispatchQueue(label: "ImageCache.ioQueue")
    
    private init() {
        cache.countLimit = 50
    }
    
    func clearCache() {
        cacheQueue.async {
            self.cache.removeAllObjects()
        }
    }
    
    func setCacheLimited(value: Int) {
        cache.countLimit = value
    }
    
    func setImage(image: UIImage, forKey key: String) {
        cacheQueue.async {
            self.cache.setObject(image, forKey: key as NSString)
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
}
