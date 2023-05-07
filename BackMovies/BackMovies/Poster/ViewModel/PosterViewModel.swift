//
//  PosterViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 12/04/23.
//

import Foundation
import Alamofire

protocol PosterViewModelDelegate: AnyObject {
    func didFetchMovies()
    func didFailToFetchMovies(with error: String)
}

class PosterViewModel {
    
    private weak var delegate: PosterViewModelDelegate?
    private let service: Service = Service()
    private var posterList: Movies?
    
    func setDelegate(delegate: PosterViewModelDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Getters
    
    public func getMoviesId(index: Int) -> Int {
        posterList?.results?[index].id ?? 0 
    }
    
    public func getCgSize() -> CGSize {
        return CGSize(width: 140, height: 260)
    }
    
    public func getPoster(index: Int) -> Poster {
       return posterList?.results?[index] ?? Poster()
    }
    
    public func getPosterCount() -> Int {
        return posterList?.results?.count ?? 0
    }
    
    //MARK: - FetchMovies
    
    public func fetchMovies() {
        AF.request(Api.posterUrl(), method: .get).validate().responseDecodable(of: Movies.self) { response in
            switch response.result {
            case .success(let result):
                self.posterList = result
                self.delegate?.didFetchMovies()
            case .failure(let error):
                self.delegate?.didFailToFetchMovies(with: error.localizedDescription)
            }
        }
    }
    
}
