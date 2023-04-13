//
//  PosterViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 12/04/23.
//

import Foundation

class PosterViewModel {
    
    let service: Service = Service()
    
    var posterList: Movies?
    
    
    
    public func fetchMovies() {
        let net = NetworkRequest(endpointURL: "https://api.themoviedb.org/3/movie/now_playing?api_key=a418c1d2207524b9f775ba6cb3c50ad6&language=pt-BR&region=DE&page=1")
        
        service.request(net) { (result: Result<Movies, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.posterList = success
                    print(success.results)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error")
                }
            }
        }
    }
    
}
