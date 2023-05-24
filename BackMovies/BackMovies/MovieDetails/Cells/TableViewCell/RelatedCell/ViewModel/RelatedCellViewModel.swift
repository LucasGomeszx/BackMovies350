//
//  RelatedCellViewModel.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 21/04/23.
//

import Foundation
import Alamofire

protocol RelatedCellViewModelDelegate: AnyObject {
    func didFetchSimilarMovies()
    func didFailToFetchSimilarMovies()
}

class RelatedCellViewModel {
    
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
        CGSize(width: 140, height: 275)
    }
    
    public func getSimilarMovieId(index: Int) -> Int {
        similarMovies?.results?[index].id ?? 0
    }
    
    public func setMovieId(id: Int) {
        movieId = id
    }
    
    public func fetchSimilar() {
        AF.request(Api.similarMovies(id: movieId ?? 0), method: .get).validate().responseDecodable(of: SimilarMovies.self) { response in
            switch response.result {
            case.success(let result):
                self.similarMovies = result
                self.delegate?.didFetchSimilarMovies()
            case .failure(_):
                self.delegate?.didFailToFetchSimilarMovies()
            }
        }
    }
    
}
