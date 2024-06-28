//
//  CacheAsyncImage.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/06/24.
//

import Foundation
import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ){
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let cached = ImageCacheSwiftUI[url]{
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    func cacheAndRender(phase: AsyncImagePhase) -> some View{
        if case .success (let image) = phase {
            ImageCacheSwiftUI[url] = image
        }
        return content(phase)
    }
}

fileprivate class ImageCacheSwiftUI{
    static private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCacheSwiftUI.cache[url]
        }
        set {
            ImageCacheSwiftUI.cache[url] = newValue
        }
    }
}
