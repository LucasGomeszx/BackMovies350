//
//  PosterViewModelSwiftUI.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 18/06/24.
//

import Foundation

@MainActor
class PosterViewModelSwiftUI: ObservableObject {
    
    @Published var posterList: MoviesModel = MoviesModel()
    
    public func fetchMovies() async throws {
        do {
            let posterList = try await SwiftUIServiceManeger().fetchMovies()
            self.posterList = posterList
        } catch {
            
        }
    }
    
}
