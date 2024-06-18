//
//  PosterViewModelSwiftUI.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 18/06/24.
//

import Foundation

class PosterViewModelSwiftUI: ObservableObject {
    
    @Published var posterList: MoviesModel = MoviesModel()
    
    public func fetchMovies() {
        ServiceManeger.shared.fetchMovies { result in
            switch result {
            case .success(let success):
                print(success)
                self.posterList = success
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
