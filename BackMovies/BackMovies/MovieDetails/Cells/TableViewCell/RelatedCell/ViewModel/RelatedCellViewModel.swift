//
//  RelatedCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation

protocol RelatedCellViewModelDelegate: AnyObject {
    func didFetchMovies()
    func didFailToFetchMovies(with error: String)
}

class RelatedCellViewModel {
    
    private let service: Service = Service()
    private var movieId: Int?
    private var similarMovies: SimilarMovies?
    
    weak var delegate: RelatedCellViewModelDelegate?
    
    public func setUpDelegate(delegate: RelatedCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    var getSimilarMoviesCount: Int {
        similarMovies?.results?.count ?? 0
    }
    
    var getSimilarMovieCellSize: CGSize {
        CGSize(width: 140, height: 260)
    }
    
    public func getSimilarMovieId(index: Int) -> Int {
        similarMovies?.results?[index].id ?? 0
    }
    
    public func setMovieId(id: Int) {
        movieId = id
    }
    
    public func fetchSimilar() {
        let url = NetworkRequest(endpointURL: Api.similarMovies(id: movieId ?? 0))
        service.request(url) { (result: Result<SimilarMovies, NetworkError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.similarMovies = success
                    self.delegate?.didFetchMovies()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.delegate?.didFailToFetchMovies(with: failure.localizedDescription)
                }
            }
        }
    }
    
}
